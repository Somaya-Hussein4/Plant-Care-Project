import 'package:flutter/material.dart';

class CenteredImage extends StatelessWidget {
  final String imagePath;
  final double borderRadius;
  final double height;

  const CenteredImage({
    super.key,
    required this.imagePath,
    this.borderRadius = 20,
    this.height = 619,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(borderRadius),
        bottomRight: Radius.circular(borderRadius),
      ),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
