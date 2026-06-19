import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'image_placeholder.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.article,
    required this.onTap,
  });

  final Map<String, String> article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(10.h),
        decoration: _cardDecoration,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.asset(
                article['img']!,
                width: 90.w,
                height: 90.h,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    ImagePlaceholder(width: 90.w, height: 90.h),
              ),
            ),
            SizedBox(width: 15.w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['title']!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      fontFamily: 'Itim',
                      color: const Color(0xFF2D6A4F),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Essential tips for healthy plants.',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 14),
                      SizedBox(width: 5.w),
                      Text(
                        '5 mins Read',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

BoxDecoration get _cardDecoration => BoxDecoration(
      color: const Color(0xFFD8F8D1),
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: const Color(0xFFB9E8B1)),
    );
