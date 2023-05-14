import 'package:flutter/material.dart';

enum TriangleDirection { left, right }

class TriangleWidget extends CustomPainter {
  final Color color;
  final TriangleDirection direction;

  const TriangleWidget({this.color = Colors.blue, required this.direction});

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2.0;
    const bottomLength = 10.0;
    // 画笔
    Paint paint = Paint()
      ..isAntiAlias = true
      ..color = color
      ..blendMode = BlendMode.colorDodge
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, centerY - bottomLength / 2.0);
    path.lineTo(0, centerY + bottomLength / 2.0);
    path.lineTo(size.width, centerY);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
