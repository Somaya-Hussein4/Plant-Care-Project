import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'image_placeholder.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({
    super.key,
    required this.video,
    required this.thumbnail,
    required this.onTap,
  });

  final Map<String, String> video;
  final String thumbnail;
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
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.network(
                    thumbnail,
                    width: 90.w,
                    height: 90.h,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        ImagePlaceholder(width: 90.w, height: 90.h),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Color(0xFF6EE014),
                    size: 18,
                  ),
                ),
              ],
            ),
            SizedBox(width: 15.w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video['title']!,
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
                    video['subtitle']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      const Icon(Icons.play_arrow_sharp, size: 14),
                      SizedBox(width: 5.w),
                      Text(
                        video['time']!,
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
