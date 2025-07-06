import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';

class QuestionWidget extends StatelessWidget {
  final String questionText;
  final int? questionNumber;
  final Color backgroundColor;
  final Color textColor;
  final double? textSize;
  final double? titleSize;
  final double? maxWidth;

  const QuestionWidget({
    super.key,
    required this.questionText,
    this.questionNumber,
    this.backgroundColor = AppColors.primary,
    this.textColor = Colors.white,
    this.textSize,
    this.titleSize,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: CustomShadowStyle.customCircleShadows(
          color: backgroundColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Titre "Question X" (si un numéro est fourni)
          if (questionNumber != null)
            Text(
              'Question ${questionNumber!}',
              style: TextStyle(
                fontSize: titleSize ?? 16.sp,
                fontWeight: FontWeight.w500,
                color: textColor,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),

          // Espacer entre le titre et la question (si un numéro est fourni)
          if (questionNumber != null) SizedBox(height: 8.h),

          // Texte de la question
          Text(
            questionText,
            style: TextStyle(
              fontSize: textSize ?? 18.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
              fontFamily: 'DynaPuff_SemiCondensed',
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
