import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/shared_widgets/nav_item.dart';

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavItem(
                  image: 'assets/images/person.png',
                  label: 'Profile',
                  isActive: currentIndex == 0,
                  onTap: () => context.go('/profile'),
                ),
                NavItem(
                  image: 'assets/images/plant.png',
                  label: 'Care Guide',
                  isActive: currentIndex == 1,
                  onTap: () => context.go('/plants'),
                ),
                const SizedBox(width: 64),
                NavItem(
                  image: 'assets/images/history.png',
                  label: 'History',
                  isActive: currentIndex == 3,
                  onTap: () => context.go('/history'),
                ),
                NavItem(
                  image: 'assets/images/bell.png',
                  label: 'Notifications',
                  isActive: currentIndex == 4,
                  onTap: () => context.go('/notifications'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
