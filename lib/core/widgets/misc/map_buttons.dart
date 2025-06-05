import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
class MapButton extends StatelessWidget {
  final String title;
  final String iconPath;
  final Color color;
  final Color shadowColor;

  const MapButton({
    super.key,
    required this.title,
    required this.iconPath,
    required this.color,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 5,
      children: [
        Container(
          width: 70.w,
          height: 70.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                spreadRadius: 2,
                blurRadius: 0,
                offset: const Offset(5, 5),
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              height: 40.h,
              width: 40.w,
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}