import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';

class MoneyPaperWidget extends StatelessWidget {
  const MoneyPaperWidget({
    super.key,
    required this.assetPath,
    required this.value,
    this.width = 120,
  });

  final String assetPath;
  final int value;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ResponsiveImageAsset(assetPath: assetPath, width: width),
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 3.0,
                color: Colors.black.withValues(alpha: 0.8),
                offset: const Offset(1.5, 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
