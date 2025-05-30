import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';

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

  // @override
  // Widget build(BuildContext context) {
  //   return Positioned(
  //     top: 0,
  //     left: 0,
  //     right: 0,
  //     child: Column(
  //       children: [
  //         SvgPicture.asset(
  //           color.assetPath,
  //           width: DeviceUtils.getScreenWidth(context),
  //           fit: BoxFit.fitWidth,
  //         ),
  //         Transform.translate(
  //           offset: Offset(0, -50.h), //? Adjust this value to move logo up/down
  //           child: Center(
  //             child: SvgPicture.asset(
  //               SvgAssets.logoWhite,
  //               width: DeviceUtils.getScreenWidth(context) * 0.35,
  //               fit: BoxFit.fitWidth,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final double logoOffset = -(0.08.sh); // 8% of the screen height
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          SvgPicture.asset(
            color.assetPath,
            width: 1.sw, // Full screen width using ScreenUtil
            fit: BoxFit.fitWidth,
          ),
          Transform.translate(
            offset: Offset(0, logoOffset), // Move logo up by 50 logical pixels
            child: Center(
              child: SvgPicture.asset(
                SvgAssets.logoWhite,
                width: 0.35.sw, // 35% of the screen width
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
