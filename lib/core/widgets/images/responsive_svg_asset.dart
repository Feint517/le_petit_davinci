import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/utils/svg_utils.dart';

class ResponsiveSvgAsset extends StatelessWidget {
  const ResponsiveSvgAsset({
    super.key,
    this.svgKey,
    required this.assetPath,
    this.width,
    this.fallbackAspectRatio = 0.3,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.topCenter,
    this.filterColor = Colors.grey,
    this.filtered = false,
  });

  final Key? svgKey;
  final String assetPath;
  final double? width;
  final double fallbackAspectRatio;
  final BoxFit fit;
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

        return SvgPicture.asset(
          key: svgKey,
          assetPath,
          width: width ?? DeviceUtils.getScreenWidth(context),
          height: calculatedHeight,
          fit: fit,
          alignment: alignment,
          colorFilter:
              filtered
                  ? ColorFilter.mode(filterColor, BlendMode.saturation)
                  : null,
        );
      },
    );
  }
}
