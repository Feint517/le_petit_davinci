import 'package:flutter/material.dart';

class CustomGridLayout extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int columns;
  final double spacing;
  final double childAspectRatio;

  const CustomGridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.columns = 2,
    this.spacing = 8.0,
    this.childAspectRatio = 1.0, // Default to 1.0 (a square)
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
