import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class ChoiceOption extends StatelessWidget {
  const ChoiceOption({
    super.key,
    required this.image,
    this.isSvg = true,
    this.onTap,
  });

  final String image;
  final bool isSvg;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: AppColors.accentDark,
              spreadRadius: 2,
              blurRadius: 0,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Center(
          child: isSvg ? SvgPicture.asset(image) : Image.asset(image),
        ),
      ),
    );
  }
}
