import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/widgets/custom_shapes/curved_edges/curved_edges_u_shape.dart';

class CurvedEdgesUShapeWidget extends StatelessWidget {
  const CurvedEdgesUShapeWidget({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: CustomCurvedEdgesUShape(), child: child);
  }
}