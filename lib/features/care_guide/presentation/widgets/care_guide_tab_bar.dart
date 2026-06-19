import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/care_guide/presentation/cubit/care_guide_state.dart';

class CareGuideTabBar extends StatelessWidget {
  const CareGuideTabBar({
    super.key,
    required this.activeTab,
    required this.onTabSelected,
  });

  final CareGuideTab activeTab;
  final ValueChanged<CareGuideTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          _Tab(
            label: 'Articles',
            active: activeTab == CareGuideTab.articles,
            onTap: () => onTabSelected(CareGuideTab.articles),
          ),
          SizedBox(width: 10.w),
          _Tab(
            label: 'Videos',
            active: activeTab == CareGuideTab.videos,
            onTap: () => onTabSelected(CareGuideTab.videos),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF77F098) : Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: const Color(0xFF6EE014)),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: active ? Colors.black : const Color(0xFF75E00A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
