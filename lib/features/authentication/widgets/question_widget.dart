import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

/// Un widget qui affiche une question dans une bulle bleue arrondie.
///
/// Ce widget est utilisé pour afficher les questions de manière uniforme
/// à travers l'application, avec un style visuel adapté aux enfants.
class QuestionWidget extends StatelessWidget {
  /// Le texte de la question à afficher
  final String questionText;

  /// Le numéro de la question (optionnel)
  final int? questionNumber;

  /// Couleur de fond de la bulle (par défaut: bluePrimary)
  final Color backgroundColor;

  /// Couleur du texte (par défaut: white)
  final Color textColor;

  /// Taille du texte de la question (par défaut: 18.sp)
  final double? textSize;

  /// Taille du texte du titre (par défaut: 16.sp)
  final double? titleSize;

  /// Largeur maximale de la bulle (optionnel)
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
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 6,
            color: Colors.black.withAlpha(20),
          ),
        ],
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
