import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    this.bubbleColor = Colors.blue,
    this.width,
    this.borderColor,
    this.borderWidth = 2.0,
    required this.bubbleText,
    this.textColor = Colors.white,
  });

  final Color bubbleColor;
  final double? width;
  final Color? borderColor;
  final double borderWidth;
  final String bubbleText;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: CustomPaint(
        painter: ChatBubblePainter(
          bubbleColor: bubbleColor,
          borderColor: borderColor,
          borderWidth: borderWidth,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 15, 15, 15),
          child: Text(
            bubbleText,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}

/// A custom painter to draw the chat bubble shape.
class ChatBubblePainter extends CustomPainter {
  // ...existing code...
  ChatBubblePainter({
    required this.bubbleColor,
    this.borderColor,
    this.borderWidth = 2.0,
  });
  final Color bubbleColor;
  final Color? borderColor;
  final double borderWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint =
        Paint()
          ..color = bubbleColor
          ..style = PaintingStyle.fill;

    const double triangleWidth = 10.0;
    const double triangleHeight = 15.0;
    const double radius = 12.0;

    final path = Path();

    // Create the rounded rectangle for the main body of the bubble
    final RRect bubbleBody = RRect.fromLTRBR(
      triangleWidth, // Left offset for the triangle
      0,
      size.width,
      size.height,
      const Radius.circular(radius),
    );

    path.addRRect(bubbleBody);

    // Create the triangle path
    final Path trianglePath =
        Path()
          ..moveTo(triangleWidth, size.height / 2 - triangleHeight / 2)
          ..lineTo(0, size.height / 2)
          ..lineTo(triangleWidth, size.height / 2 + triangleHeight / 2)
          ..close();

    // Combine the triangle with the bubble body
    path.addPath(trianglePath, Offset.zero);

    // Draw the fill
    canvas.drawPath(path, fillPaint);

    // Draw the border if a color is provided
    if (borderColor != null) {
      final borderPaint =
          Paint()
            ..color = borderColor!
            ..style = PaintingStyle.stroke
            ..strokeWidth = borderWidth;
      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
