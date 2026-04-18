import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/custom_app_text.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';
import 'package:graduation_project/features/about_us/presentation/widgets/feature_item.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              CustomAppText(title: 'About Us'),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 3.h),
                child: Row(
                  children: [
                    Image.asset('assets/images/leaf.png',
                        color: ColorsManager.darkGreen,
                        height: 90.h,
                        width: 90.w),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'Plant Care',
                        style: TextStyles.font29darkGreen900weight,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                width: 370.w,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorsManager.borderGrey),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                      'Plant Care is a mobile application dedicated to helping tomato growers keep their plants healthy. In this version, all features are focused exclusively on tomato plants — from disease detection to daily care tips.',
                      style: TextStyles.font16DarkGrey400Weight),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: 370.w,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorsManager.borderGrey),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What We Offer:',
                        style: TextStyles.font20Black900weight,
                      ),
                      SizedBox(height: 16.h),
                      FeatureItem(
                        icon: Icons.local_florist,
                        iconBgColor: ColorsManager.lightGrey,
                        iconColor: ColorsManager.darkGreen,
                        title: 'Tomato Disease Diagnosis',
                        description:
                            'Snap a photo of your tomato plant, and our AI will analyze it to identify any diseases or pests.',
                      ),
                      SizedBox(height: 16.h),
                      FeatureItem(
                        icon: Icons.notification_important,
                        iconBgColor: ColorsManager.lightGrey,
                        iconColor: ColorsManager.darkGreen,
                        title: 'Smart Notifications',
                        description:
                            'Get reminders to check on your plants as well as alerts for watering your plants based on weather conditions.',
                      ),
                      SizedBox(height: 16.h),
                      FeatureItem(
                        icon: Icons.light_mode,
                        iconBgColor: ColorsManager.lightGrey,
                        iconColor: ColorsManager.darkGreen,
                        title: ' Care Guide',
                        description:
                            'Articles and videos on growing, watering and healing your tomato plants__practical tips for everyday growers.',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: 370.w,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      ColorsManager.primaryGreen,
                      ColorsManager.secondaryGreen,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Text(
                      'This version supports tomato plants only. More plant types and features are coming soon!',
                      style: TextStyles.font18DarkGreen400Weight,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                width: 370.w,
                height: 90.h,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorsManager.borderGrey),
                ),
                child: Center(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Developed as a graduation project.',
                            style: TextStyles.font14DarkGrey400Weight),
                        TextSpan(
                            text:
                                '\nFaculty of Computers and Information Technology.',
                            style: TextStyles.font14Black400Weight),
                        TextSpan(
                            text: '\nVersion 1.0.0',
                            style: TextStyles.font14DarkGrey400Weight),
                      ])),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
