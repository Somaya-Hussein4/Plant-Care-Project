import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/shared_widgets/custom_app_text.dart';
import 'package:graduation_project/core/shared_widgets/gradient_border_container.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';
import 'package:graduation_project/features/about_us/presentation/widgets/feature_item.dart';
import 'package:graduation_project/generated/l10n.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Transform.translate(
                  offset: Offset(0, -10),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 48),
                        Expanded(
                          child: CustomAppText(
                            title: (context) => S.of(context).aboutUs,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.go('/profile');
                          },
                          icon: ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                ColorsManager.primaryGreen,
                                ColorsManager.secondaryGreen
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds),
                            child: Icon(
                              Directionality.of(context) == TextDirection.rtl
                                  ? Icons.arrow_circle_left_outlined
                                  : Icons.arrow_circle_right_outlined,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 1.h),
                child: Row(
                  children: [
                    Image.asset('assets/images/leaf.png',
                        color: ColorsManager.darkGreen,
                        height: 90.h,
                        width: 90.w),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        S.of(context).plantCare,
                        style: TextStyles.font29darkGreen900weight,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              // About description card
              GradientBorderContainer(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    S.of(context).aboutDescription,
                    style: TextStyles.font16DarkGrey400Weight,
                  ),
                ),
              ),

              SizedBox(height: 20.h),
              // What we offer card
              GradientBorderContainer(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).whatWeOffer,
                        style: TextStyles.font20Black900weight,
                      ),
                      SizedBox(height: 16.h),
                      FeatureItem(
                        icon: Icons.local_florist,
                        iconBgColor: ColorsManager.lightGrey,
                        iconColor: ColorsManager.darkGreen,
                        title: S.of(context).featureDiseaseTitle,
                        description: S.of(context).featureDiseaseDescription,
                      ),
                      SizedBox(height: 16.h),
                      FeatureItem(
                        icon: Icons.notification_important,
                        iconBgColor: ColorsManager.lightGrey,
                        iconColor: ColorsManager.darkGreen,
                        title: S.of(context).featureNotificationsTitle,
                        description:
                            S.of(context).featureNotificationsDescription,
                      ),
                      SizedBox(height: 16.h),
                      FeatureItem(
                        icon: Icons.light_mode,
                        iconBgColor: ColorsManager.lightGrey,
                        iconColor: ColorsManager.darkGreen,
                        title: S.of(context).featureCareGuideTitle,
                        description: S.of(context).featureCareGuideDescription,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),

// Version note card
              GradientBorderContainer(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: ColorsManager.darkGreen.withOpacity(0.8),
                      size: 18,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        S.of(context).aboutVersionNote,
                        style: TextStyles.font18DarkGreen400Weight,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

// Footer card
              GradientBorderContainer(
                child: SizedBox(
                  height: 90.h,
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: S.of(context).projectDescription,
                            style: TextStyles.font14DarkGrey400Weight,
                          ),
                          TextSpan(
                            text: '\n${S.of(context).facultyDescription}',
                            style: TextStyles.font14Black400Weight,
                          ),
                          TextSpan(
                            text: '\n${S.of(context).versionDescription}',
                            style: TextStyles.font14DarkGrey400Weight.copyWith(
                              color: ColorsManager.darkGrey.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
