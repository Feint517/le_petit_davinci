import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/utils/svg_utils.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';

class CustomCircularImage extends StatelessWidget {
  const CustomCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.overlayColor,
    this.backgroundColor,
    this.boderColor,
    required this.image,
    this.fit = BoxFit.cover,
    this.padding = AppSizes.sm,
    this.isNetworkImage = false,
  });

  final BoxFit fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final Color? boderColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (DeviceUtils.isDarkMode(context)
                ? AppColors.black
                : AppColors.white),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Color.alphaBlend(
            Colors.black.withValues(alpha: 0.3),
            boderColor ?? Colors.transparent,
          ),
          width: 4,
        ),
      ),
      child: Center(
        child:
            ImageUtils.isSvg(image)
                ? ResponsiveSvgAsset(assetPath: image, width: width, fit: fit)
                : Image(
                  image:
                      isNetworkImage
                          ? NetworkImage(image)
                          : AssetImage(image) as ImageProvider,
                  fit: fit,
                  color: overlayColor,
                ),
      ),
    );
  }
}
