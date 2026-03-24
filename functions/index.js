const functions = require("firebase-functions");
const admin = require("firebase-admin");
const axios = require("axios");

admin.initializeApp();
const db = admin.firestore();
const messaging = admin.messaging();

// ─────────────────────────────────────────────
// PROACTIVE NOTIFICATIONS
// Runs every hour — fires with ~25% probability
// so the user gets roughly 4–6 random notifications per day
// ─────────────────────────────────────────────

const PROACTIVE_MESSAGES = [
    {
        title: "🌿 Plant Check-In!",
        body: "Your green friends miss you! Have you checked on them today?",
    },
    {
        title: "💧 Hydration Time?",
        body: "Don't forget — your plants might be thirsty. Give them a little love!",
    },
    {
        title: "🌱 Growth Update",
        body: "Plants grow when you care. Take a moment to check your little ones!",
    },
    {
        title: "☀️ Sunshine & Plants",
        body: "Is your plant getting enough light today? A small move can make a big difference.",
    },
    {
        title: "🍃 Leaf Check",
        body: "Spotted any yellow leaves? Open the app to diagnose your plant's health!",
    },
    {
        title: "🌺 Bloom Season",
        body: "Healthy plants = happy home. Time to give your plants some attention!",
    },
    {
        title: "🪴 Plant Parent Reminder",
        body: "Great plant parents check in regularly. How are your plants doing today?",
    },
    {
        title: "🔬 Disease Check",
        body: "Noticed something off with a leaf? Snap a photo and let AI diagnose it for you!",
    },
];

exports.sendProactiveNotifications = functions.pubsub
    .schedule("every 60 minutes")
    .onRun(async () => {
        // Only fire ~25% of the time to simulate "random time"
        if (Math.random() > 0.25) {
            console.log("Proactive notification skipped this hour.");
            return null;
        }

        const message =
            PROACTIVE_MESSAGES[Math.floor(Math.random() * PROACTIVE_MESSAGES.length)];

        const usersSnapshot = await db.collection("users").get();
        if (usersSnapshot.empty) return null;

        const sendPromises = [];

        for (const userDoc of usersSnapshot.docs) {
            const userData = userDoc.data();
            const fcmToken = userData.fcmToken;
            if (!fcmToken) continue;

            // Store notification in Firestore for the in-app list
            const notificationRef = db
                .collection("users")
                .doc(userDoc.id)
                .collection("notifications")
                .doc();

            sendPromises.push(
                notificationRef.set({
                    id: notificationRef.id,
                    type: "proactive",
                    title: message.title,
                    body: message.body,
                    isRead: false,
                    createdAt: admin.firestore.FieldValue.serverTimestamp(),
                })
            );

            sendPromises.push(
                messaging.send({
                    token: fcmToken,
                    notification: { title: message.title, body: message.body },
                    data: { type: "proactive", notificationId: notificationRef.id },
                    android: { priority: "normal" },
                    apns: { payload: { aps: { sound: "default" } } },
                })
            );
        }

        await Promise.allSettled(sendPromises);
        console.log(`Proactive notification sent: "${message.title}"`);
        return null;
    });

// ─────────────────────────────────────────────
// WEATHER-BASED NOTIFICATIONS
// Runs every day at 8 PM UTC — checks tomorrow's forecast
// Uses each user's stored latitude & longitude
// ─────────────────────────────────────────────

// WMO weather codes that indicate rain/snow/precipitation
const RAIN_CODES = new Set([
    51, 53, 55,     // Drizzle
    61, 63, 65,     // Rain
    66, 67,         // Freezing rain
    71, 73, 75, 77, // Snow
    80, 81, 82,     // Rain showers
    85, 86,         // Snow showers
    95,             // Thunderstorm
    96, 99,         // Thunderstorm with hail
]);

function getRainMessage(weatherCode) {
    if ([71, 73, 75, 77, 85, 86].includes(weatherCode)) {
        return {
            title: "❄️ Snow Expected Tomorrow",
            body: "Snow is in the forecast! Move outdoor plants inside and skip watering today.",
        };
    }
    if ([95, 96, 99].includes(weatherCode)) {
        return {
            title: "⛈️ Storm Alert for Tomorrow",
            body: "A thunderstorm is coming! Protect your plants and hold off on watering.",
        };
    }
    return {
        title: "🌧️ Rain Tomorrow — Skip Watering!",
        body: "Rain is expected tomorrow. No need to water your plants today — let nature do it!",
    };
}

exports.sendWeatherNotifications = functions.pubsub
    .schedule("0 20 * * *") // Every day at 8:00 PM UTC
    .timeZone("UTC")
    .onRun(async () => {
        const usersSnapshot = await db.collection("users").get();
        if (usersSnapshot.empty) return null;

        const tomorrow = new Date();
        tomorrow.setDate(tomorrow.getDate() + 1);
        const tomorrowStr = tomorrow.toISOString().split("T")[0];

        const sendPromises = [];

        for (const userDoc of usersSnapshot.docs) {
            const userData = userDoc.data();
            const fcmToken = userData.fcmToken;
            const latitude = userData.latitude;
            const longitude = userData.longitude;

            if (!fcmToken || latitude === undefined || longitude === undefined) continue;

            try {
                const weatherUrl =
                    `https://api.open-meteo.com/v1/forecast` +
                    `?latitude=${latitude}&longitude=${longitude}` +
                    `&daily=weathercode,precipitation_sum` +
                    `&timezone=auto` +
                    `&start_date=${tomorrowStr}&end_date=${tomorrowStr}`;

                const response = await axios.get(weatherUrl);
                const daily = response.data?.daily;

                if (!daily || !daily.weathercode || daily.weathercode.length === 0) continue;

                const tomorrowCode = daily.weathercode[0];
                const precipitationSum = daily.precipitation_sum?.[0] ?? 0;

                // Only notify if it's actually going to rain
                if (!RAIN_CODES.has(tomorrowCode) && precipitationSum < 1) continue;

                const message = getRainMessage(tomorrowCode);

                const notificationRef = db
                    .collection("users")
                    .doc(userDoc.id)
                    .collection("notifications")
                    .doc();

                sendPromises.push(
                    notificationRef.set({
                        id: notificationRef.id,
                        type: "weather",
                        title: message.title,
                        body: message.body,
                        isRead: false,
                        weatherCode: tomorrowCode,
                        precipitationSum,
                        createdAt: admin.firestore.FieldValue.serverTimestamp(),
                    })
                );

                sendPromises.push(
                    messaging.send({
                        token: fcmToken,
                        notification: { title: message.title, body: message.body },
                        data: {
                            type: "weather",
                            notificationId: notificationRef.id,
                            weatherCode: String(tomorrowCode),
                        },
                        android: { priority: "high" },
                        apns: { payload: { aps: { sound: "default" } } },
                    })
                );
            } catch (error) {
                console.error(`Weather fetch failed for user ${userDoc.id}:`, error);
            }
        }

        await Promise.allSettled(sendPromises);
        console.log("Weather-based notifications processed.");
        return null;
    });