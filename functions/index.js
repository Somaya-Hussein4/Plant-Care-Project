const { onSchedule } = require("firebase-functions/v2/scheduler");
const admin = require("firebase-admin");
const axios = require("axios");

admin.initializeApp();
const db = admin.firestore();
const messaging = admin.messaging();

// ─────────────────────────────────────────────
// MESSAGES — English & Arabic
// ─────────────────────────────────────────────

const PROACTIVE_MESSAGES = {
    en: [
        { title: "🌿 Plant Check-In!", body: "Your green friends miss you! Have you checked on them today?" },
        { title: "💧 Hydration Time?", body: "Don't forget — your plants might be thirsty. Give them a little love!" },
        { title: "🌱 Growth Update", body: "Plants grow when you care. Take a moment to check your little ones!" },
        { title: "☀️ Sunshine & Plants", body: "Is your plant getting enough light today? A small move can make a big difference." },
        { title: "🍃 Leaf Check", body: "Spotted any yellow leaves? Open the app to diagnose your plant's health!" },
        { title: "🌺 Bloom Season", body: "Healthy plants = happy home. Time to give your plants some attention!" },
        { title: "🪴 Plant Parent Reminder", body: "Great plant parents check in regularly. How are your plants doing today?" },
        { title: "🔬 Disease Check", body: "Noticed something off with a leaf? Snap a photo and let AI diagnose it for you!" },
    ],
    ar: [
        { title: "🌿 تفقد نباتاتك!", body: "نباتاتك تفتقدك! هل تفقدتها اليوم؟" },
        { title: "💧 وقت السقي؟", body: "لا تنسَ — نباتاتك قد تكون عطشى. أعطها بعض الاهتمام!" },
        { title: "🌱 متابعة النمو", body: "النباتات تنمو حين تعتني بها. خصص لحظة لتفقد نباتاتك الصغيرة!" },
        { title: "☀️ النباتات والضوء", body: "هل تحصل نباتاتك على ضوء كافٍ اليوم؟ تحريكها قليلاً قد يحدث فرقاً كبيراً." },
        { title: "🍃 فحص الأوراق", body: "لاحظت أوراقاً صفراء؟ افتح التطبيق لتشخيص صحة نباتاتك!" },
        { title: "🌺 موسم الإزهار", body: "النباتات الصحية = بيت سعيد. حان وقت الاهتمام بنباتاتك!" },
        { title: "🪴 تذكير مربي النباتات", body: "مربو النباتات المثاليون يتفقدونها باستمرار. كيف هي نباتاتك اليوم؟" },
        { title: "🔬 فحص الأمراض", body: "لاحظت شيئاً غريباً في الأوراق؟ التقط صورة ودع الذكاء الاصطناعي يشخصها!" },
    ],
};

function getRainMessage(code, lang) {
    if (lang === 'ar') {
        if ([71, 73, 75, 77, 85, 86].includes(code)) return { title: "❄️ ثلج متوقع غداً", body: "الثلج في التوقعات! انقل النباتات الخارجية للداخل وتوقف عن السقي اليوم." };
        if ([95, 96, 99].includes(code)) return { title: "⛈️ تحذير من عاصفة غداً", body: "عاصفة رعدية قادمة! احمِ نباتاتك وتوقف عن السقي." };
        return { title: "🌧️ مطر غداً — لا تسقِ!", body: "من المتوقع هطول المطر غداً. لا حاجة لسقي نباتاتك — دع الطبيعة تفعل ذلك!" };
    }
    if ([71, 73, 75, 77, 85, 86].includes(code)) return { title: "❄️ Snow Expected Tomorrow", body: "Snow is in the forecast! Move outdoor plants inside and skip watering today." };
    if ([95, 96, 99].includes(code)) return { title: "⛈️ Storm Alert for Tomorrow", body: "A thunderstorm is coming! Protect your plants and hold off on watering." };
    return { title: "🌧️ Rain Tomorrow — Skip Watering!", body: "Rain is expected tomorrow. No need to water your plants today — let nature do it!" };
}

// ─────────────────────────────────────────────
// PROACTIVE NOTIFICATIONS
// ─────────────────────────────────────────────

const RAIN_CODES = new Set([51, 53, 55, 61, 63, 65, 66, 67, 71, 73, 75, 77, 80, 81, 82, 85, 86, 95, 96, 99]);

exports.sendProactiveNotifications = onSchedule("every 60 minutes", async () => {
    if (Math.random() > 0.25) { console.log("Skipped."); return; }

    const usersSnapshot = await db.collection("users").get();
    if (usersSnapshot.empty) return;

    const sendPromises = [];

    for (const userDoc of usersSnapshot.docs) {
        const { fcmToken, language } = userDoc.data();
        if (!fcmToken) continue;

        const lang = language === 'ar' ? 'ar' : 'en';
        const messages = PROACTIVE_MESSAGES[lang];
        const message = messages[Math.floor(Math.random() * messages.length)];

        const notificationRef = db.collection("users").doc(userDoc.id).collection("notifications").doc();

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
    console.log("Proactive notifications sent.");
});

// ─────────────────────────────────────────────
// WEATHER-BASED NOTIFICATIONS
// ─────────────────────────────────────────────

exports.sendWeatherNotifications = onSchedule({ schedule: "0 20 * * *", timeZone: "UTC" }, async () => {
    const usersSnapshot = await db.collection("users").get();
    if (usersSnapshot.empty) return;

    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    const tomorrowStr = tomorrow.toISOString().split("T")[0];
    const sendPromises = [];

    for (const userDoc of usersSnapshot.docs) {
        const { fcmToken, latitude, longitude, language } = userDoc.data();
        if (!fcmToken || latitude === undefined || longitude === undefined) continue;

        const lang = language === 'ar' ? 'ar' : 'en';

        try {
            const response = await axios.get(
                `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&daily=weathercode,precipitation_sum&timezone=auto&start_date=${tomorrowStr}&end_date=${tomorrowStr}`
            );
            const daily = response.data?.daily;
            if (!daily || !daily.weathercode || daily.weathercode.length === 0) continue;

            const tomorrowCode = daily.weathercode[0];
            const precipitationSum = daily.precipitation_sum?.[0] ?? 0;
            if (!RAIN_CODES.has(tomorrowCode) && precipitationSum < 1) continue;

            const message = getRainMessage(tomorrowCode, lang);
            const notificationRef = db.collection("users").doc(userDoc.id).collection("notifications").doc();

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
                    data: { type: "weather", notificationId: notificationRef.id, weatherCode: String(tomorrowCode) },
                    android: { priority: "high" },
                    apns: { payload: { aps: { sound: "default" } } },
                })
            );
        } catch (error) {
            console.error(`Weather failed for ${userDoc.id}:`, error);
        }
    }

    await Promise.allSettled(sendPromises);
    console.log("Weather notifications processed.");
});