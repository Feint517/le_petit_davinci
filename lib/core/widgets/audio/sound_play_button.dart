import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';

class SoundPlayButton extends StatelessWidget {
  const SoundPlayButton({
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
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Center(
          child:
              isSvg
                  ? ResponsiveImageAsset(assetPath: icon, width: 50)
                  : Image.asset(icon),
        ),
      ),
    );
  }
}
