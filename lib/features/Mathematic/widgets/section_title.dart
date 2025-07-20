import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFF2D3D41))),
        const Gap(16),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF52656D),
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const Gap(16),
        const Expanded(child: Divider(color: Color(0xFF2D3D41))),
      ],
    );
  }
}
