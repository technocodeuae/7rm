import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io';

class HexagonImage extends StatelessWidget {
  final double size;
  final String imageUrl;
  final String? imagePath;
  final bool isFile;

  HexagonImage({required this.size, required this.imageUrl,required this.isFile, this.imagePath});
////
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HexagonPainter(),
      child: ClipPath(
        clipper: _HexagonClipper(),
        child: isFile ? Image.file(
            File(imagePath!) ): Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Image.asset(
                'assets/images/main/7rmlogo.png',
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HexagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // رسم الشكل السداسي هنا، يمكنك استخدام الكود السابق
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    path.moveTo(centerX + radius * cos(0), centerY + radius * sin(0));

    for (var i = 1; i <= 6; i++) {
      final angle = 2.0 * pi * i / 6;
      final x = centerX + radius * cos(angle);
      final y = centerY + radius * sin(angle);
      path.lineTo(x, y);
    }

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
