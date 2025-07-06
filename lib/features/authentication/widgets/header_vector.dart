import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';

enum HeaderVectorColor {
  blue,
  green,
  purple;

  String get assetPath {
    return switch (this) {
      HeaderVectorColor.blue => SvgAssets.headerVectorBlue,
      HeaderVectorColor.green => SvgAssets.headerVectorGreen,
      HeaderVectorColor.purple => SvgAssets.headerVectorPurple,
    };
  }
}

class HeaderVector extends StatelessWidget {
  const HeaderVector({required this.color, super.key});

  final HeaderVectorColor color;

  @override
  Widget build(BuildContext context) {
    // 8% of the screen height
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          ResponsiveImageAsset(assetPath: color.assetPath),
          Transform.translate(
            offset: Offset(0, -(0.08.sh)), //? 8% of the screen height
            child: Center(
              child: ResponsiveImageAsset(
                assetPath: SvgAssets.logoWhite,
                width: DeviceUtils.getScreenWidth(context) * 0.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
