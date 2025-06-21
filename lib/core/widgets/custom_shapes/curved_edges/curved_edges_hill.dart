import 'package:flutter/material.dart';

class CustomCurvedEdgesHill extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);

    //? Curve upward at the bottom (hill shape)
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 160, //? control point above the bottom edge for a hill
      size.width,
      size.height - 80,
    );

    // path.quadraticBezierTo(
    //   size.width / 2,
    //   size.height - 80, // control point for the curve
    //   size.width,
    //   size.height,
    // );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
