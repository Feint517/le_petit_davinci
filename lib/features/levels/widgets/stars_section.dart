import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';

class StarsSection extends StatelessWidget {
  const StarsSection({super.key, required this.starsCount});

  final int starsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSizes.md,
      children: List.generate(
        starsCount,
        (index) => ResponsiveImageAsset(
          assetPath: SvgAssets.star,
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
