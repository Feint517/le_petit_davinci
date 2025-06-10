import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LessonBadge extends StatelessWidget {
  const LessonBadge({super.key, required this.label, required this.color, required this.svgIconPath});

  final String label;
  final Color color;
  final String svgIconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 40,
      margin: const EdgeInsets.only(
        left: 40, //? Added this line to compensate for overflow
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: .4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -55,
            top: -10,
            bottom: -10,
            child: SvgPicture.asset(svgIconPath, width: 80, height: 80),
          ),
          Center(
            child: Text(label, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}