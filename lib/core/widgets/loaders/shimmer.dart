import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerEffect extends StatelessWidget {
  const CustomShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color,
  });

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:
          DeviceUtils.isDarkMode(context)
              ? Colors.grey[850]!
              : Colors.grey[300]!,
      highlightColor:
          DeviceUtils.isDarkMode(context)
              ? Colors.grey[700]!
              : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color:
              color ??
              (DeviceUtils.isDarkMode(context)
                  ? AppColors.darkGrey
                  : AppColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
