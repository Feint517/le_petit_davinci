import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/widgets/custom_shapes/curved_edges/curved_edges_hill.dart';

class CurvedEdgesHillWidget extends StatelessWidget {
  const CurvedEdgesHillWidget({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: CustomCurvedEdgesHill(), child: child);
  }
}