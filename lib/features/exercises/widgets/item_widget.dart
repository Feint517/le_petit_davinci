import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.assetPath,
    required this.value,
    this.height = 50,
  });

  final String assetPath;
  final int value;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 1. The background image of the item.
        ResponsiveImageAsset(assetPath: assetPath, height: height),
        // 2. The text value overlaid on top.
        // Only show the value if it's greater than 1, for single items like one apple.
        if (value > 1)
          Text(
            // --- MODIFIED: Removed the hardcoded '$' symbol ---
            value.toString(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 3.0,
                  color: Colors.black.withOpacity(0.8),
                  offset: const Offset(1.5, 1.5),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
