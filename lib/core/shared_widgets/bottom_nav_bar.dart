import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/shared_widgets/nav_item.dart';
import 'package:graduation_project/generated/l10n.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // SVG Background
          SvgPicture.asset(
            'assets/svg/bar.svg',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),

          // Navigation Items
          Positioned(
            bottom: 18,
            left: 0,
            right: 0,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 70,
                    child: NavItem(
                      image: 'assets/images/person.png',
                      label: S.of(context).navProfile,
                      isActive: currentIndex == 0,
                      onTap: () => context.go('/profile'),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: NavItem(
                      image: 'assets/images/plant.png',
                      label: S.of(context).navCareGuide,
                      isActive: currentIndex == 1,
                      onTap: () => context.go('/guide'),
                    ),
                  ),
                  const SizedBox(width: 64),
                  SizedBox(
                    width: 70,
                    child: NavItem(
                      image: 'assets/images/history.png',
                      label: S.of(context).navHistory,
                      isActive: currentIndex == 3,
                      onTap: () => context.go('/history'),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: NavItem(
                      image: 'assets/images/bell.png',
                      label: S.of(context).navNotifications,
                      isActive: currentIndex == 4,
                      onTap: () => context.go('/notifications'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
