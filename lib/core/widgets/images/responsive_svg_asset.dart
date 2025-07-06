import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/utils/image_utils.dart';

class ResponsiveImageAsset extends StatelessWidget {
  const ResponsiveImageAsset({
    super.key,
    this.imageKey,
    required this.assetPath,
    this.width,
    this.fallbackAspectRatio = 0.3,
    this.fit = BoxFit.contain,
    this.scale,
    this.alignment = Alignment.topCenter,
    this.filterColor = Colors.grey,
    this.filtered = false,
  });

  final Key? imageKey;
  final String assetPath;
  final double? width;
  final double fallbackAspectRatio;
  final BoxFit fit;
  final double? scale;
  final Alignment alignment;
  final Color filterColor;
  final bool filtered;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double?>(
      future: ImageUtils.getSvgAspectRatio(assetPath),
      builder: (context, snapshot) {
        final aspectRatio = snapshot.data ?? fallbackAspectRatio;
        final calculatedHeight =
            (width ?? DeviceUtils.getScreenWidth(context)) * aspectRatio;
        final isSvg = ImageUtils.isSvg(assetPath);

        return isSvg
            ? SvgPicture.asset(
              key: imageKey,
              assetPath,
              width: width ?? DeviceUtils.getScreenWidth(context),
              height: calculatedHeight,
              fit: fit,
              alignment: alignment,
              colorFilter:
                  filtered
                      ? ColorFilter.mode(filterColor, BlendMode.saturation)
                      : null,
            )
            : Image.asset(
              key: imageKey,
              assetPath,
              width: width ?? DeviceUtils.getScreenWidth(context),
              height: calculatedHeight,
              fit: fit,
              scale: scale,
              alignment: alignment,
            );
      },
    );
  }
}
