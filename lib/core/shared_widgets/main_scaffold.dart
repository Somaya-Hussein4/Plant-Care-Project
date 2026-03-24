import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/shared_widgets/bottom_nav_bar.dart';
import 'package:graduation_project/core/theming/colors.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/profile')) return 0;
    if (location.startsWith('/plants')) return 1;
    if (location.startsWith('/history')) return 3;
    if (location.startsWith('/notifications')) return 4;

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          child,
          Positioned(
            bottom: 30.h,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      ColorsManager.primaryGreen,
                      ColorsManager.secondaryGreen,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () => context.goNamed('home'),
                    child: Image.asset(
                      'assets/images/home.png',
                      width: 36.w,
                      height: 36.h,
                      color: ColorsManager.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: BottomNavBar(
          currentIndex: _currentIndex(context),
        ),
      ),
    );
  }
}
