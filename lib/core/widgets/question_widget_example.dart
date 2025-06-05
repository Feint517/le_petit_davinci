import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/authentication/widgets/question_widget.dart';

/// Widget d'exemple pour démontrer l'utilisation du QuestionWidget
class QuestionWidgetExample extends StatelessWidget {
  const QuestionWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text(
          'Exemples QuestionWidget',
          style: TextStyle(fontFamily: 'DynaPuff_SemiCondensed'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Exemple 1: Question standard avec numéro
            const Text(
              'Exemple 1: Question standard avec numéro',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
            Gap(16.h),
            
            const QuestionWidget(
              questionText: 'Combien de temps veux-tu apprendre chaque jour?',
              questionNumber: 1,
            ),
            
            Gap(40.h),
            
            // Exemple 2: Question sans numéro
            const Text(
              'Exemple 2: Question sans numéro',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
            Gap(16.h),
            
            const QuestionWidget(
              questionText: 'Quelle est ta couleur préférée?',
            ),
            
            Gap(40.h),
            
            // Exemple 3: Question avec couleur personnalisée
            const Text(
              'Exemple 3: Question avec couleur personnalisée',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
            Gap(16.h),
            
            const QuestionWidget(
              questionText: 'Quel est ton animal préféré?',
              questionNumber: 3,
              backgroundColor: AppColors.orangeAccent,
            ),
            
            Gap(40.h),
            
            // Exemple 4: Question avec texte plus long
            const Text(
              'Exemple 4: Question avec texte plus long',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
            Gap(16.h),
            
            const QuestionWidget(
              questionText: 'Qu\'est-ce que tu aimerais apprendre le plus aujourd\'hui? Tu peux choisir parmi plusieurs activités!',
              questionNumber: 4,
              backgroundColor: AppColors.purpleAccent,
              maxWidth: 350,
            ),
            
            Gap(20.h),
          ],
        ),
      ),
    );
  }
}
