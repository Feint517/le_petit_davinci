import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/custom_shapes/curved_edges/curved_edges_hill_widget.dart';

class CustomCurvedHeaderContainer extends StatelessWidget {
  const CustomCurvedHeaderContainer({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.backgroundLight,
  });

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgesHillWidget(
      child: Container(
        color: backgroundColor,
        width: DeviceUtils.getScreenWidth(context),
        height: 400,
        child: child,
      ),
    );
  }
}
