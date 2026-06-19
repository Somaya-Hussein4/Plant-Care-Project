import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/colors.dart';
import 'package:graduation_project/core/theming/style.dart';

class ProfileHeaderCard extends StatelessWidget {
  final ImageProvider? avatarImage;
  final VoidCallback onEditTap;
  final String name;

  const ProfileHeaderCard({
    super.key,
    required this.avatarImage,
    required this.onEditTap,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              // 1. The Gradient Rectangle (The Base)
              Container(
                height: 70.h,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      ColorsManager.primaryGreen,
                      ColorsManager.secondaryGreen,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),

              // 2. The Profile Image + Edit Button
              Positioned(
                top: 10.h, // Adjusts how high the circle sits
                child: Stack(
                  children: [
                    // Circle Avatar with White Border
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: ColorsManager.white,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 60.h,
                        backgroundImage: avatarImage,
                      ),
                    ),

                    // The "On Edit Tap" Camera Icon
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: onEditTap,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: ColorsManager.midGrey),
                            boxShadow: [
                              BoxShadow(
                                color: ColorsManager.black,
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 3. The Dynamic Name
        const SizedBox(height: 12),
        Text(
          name,
          style: TextStyles.font22darkGreen400Weight,
        ),
      ],
    );
  }
}
