import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class IconSquare extends StatelessWidget {
  const IconSquare({
    super.key,
    this.backgroundColor = AppColors.accentDark,
    this.icon = SvgAssets.soundIcon,
    this.onTap,
    this.isSvg = true,
  });

  final Color backgroundColor;
  final String icon;
  final bool isSvg;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Center(child: isSvg ? SvgPicture.asset(icon) : Image.asset(icon)),
      ),
    );
  }
}
