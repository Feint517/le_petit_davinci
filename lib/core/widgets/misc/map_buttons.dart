 import 'package:flutter/material.dart'; 
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
class MapButton extends StatelessWidget {
  final String title;
  final String iconPath;
  final Color color;
  final Color shadowColor;
  final double? width ;
  final double? height;
  final VoidCallback onTap;
  const MapButton({
    super.key,
    required this.title,
    required this.iconPath,
    required this.color,
    required this.shadowColor, this.width, this.height, required this.onTap,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(spacing: 5,
        children: [
          Container(
            width: 70,
            height: 70,
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
                height: width?? 40,
                width: height?? 40,
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
      ),
    );
  }
}