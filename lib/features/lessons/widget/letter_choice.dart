
import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/custom_shapes/container/cicular_container.dart';

class LetterChoice extends StatelessWidget {
  const LetterChoice({super.key, required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    return CustomCircularContainer(
      height: 60,
      width: 60,
      child: Center(
        child: Text(
          letter.toUpperCase(),
          style: TextStyle(fontSize: 40, color: AppColors.accent),
        ),
      ),
    );
  }
}
