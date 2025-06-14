import 'package:flutter/material.dart';

class CustomCurvedEdgesUShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);

    //? Curve downward at the bottom
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 80, //? control point below the bottom edge for a "U" shape
      size.width,
      size.height - 80,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
