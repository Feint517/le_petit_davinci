import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.sectionName,
    this.fontWeight = FontWeight.w400,
  });

  final String sectionName;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionName,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.copyWith(fontWeight: fontWeight),
        ),
      ],
    );
  }
}
