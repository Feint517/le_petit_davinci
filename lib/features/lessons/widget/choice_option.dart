import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';

class ChoiceOption extends StatelessWidget {
  const ChoiceOption({
    super.key,
    required this.image,
    this.isSvg = true,
    this.isSelected = false,
    required this.onTap,
    this.isCorrect = false,
    this.isWrong = false,
  });

  final String image;
  final bool isSvg;
  final VoidCallback onTap;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    if (isCorrect) {
      backgroundColor = Colors.green;
    } else if (isWrong) {
      backgroundColor = Colors.red;
    } else if (isSelected) {
      backgroundColor = Colors.blueAccent;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: CustomShadowStyle.customCircleShadows(
            color: AppColors.accentDark,
          ),
        ),
        child: Center(
          child: isSvg ? SvgPicture.asset(image) : Image.asset(image),
        ),
      ),
    );
  }
}
