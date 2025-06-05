import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/misc/mascot_widget.dart';

/// Exemple d'utilisation du MascotWidget
/// 
/// Cette page démontre différentes configurations possibles du widget.
class MascotWidgetExample extends StatelessWidget {
  const MascotWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Exemples MascotWidget'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Exemple 1: Configuration par défaut
              const Text(
                'Exemple 1: Configuration par défaut',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DynaPuff_SemiCondensed',
                ),
              ),
              Gap(16.h),
              
              const MascotWidget(
                speechText: "Bonjour ! Moi, c'est DaVinci ! Je suis ton ami pour apprendre et t'amuser tous les jours !",
              ),
              
              Gap(40.h),
              
              // Exemple 2: Bulle personnalisée
              const Text(
                'Exemple 2: Bulle verte personnalisée',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DynaPuff_SemiCondensed',
                ),
              ),
              Gap(16.h),
              
              const MascotWidget(
                speechText: "Prêt pour une nouvelle aventure ?",
                bubbleColor: AppColors.greenPrimary,
                mascotSize: 100,
              ),
              
              Gap(40.h),
              
              // Exemple 3: Texte plus long
              const Text(
                'Exemple 3: Texte plus long',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DynaPuff_SemiCondensed',
                ),
              ),
              Gap(16.h),
              
              const MascotWidget(
                speechText: "Savais-tu que les couleurs peuvent nous aider à apprendre ? Aujourd'hui, nous allons découvrir ensemble comment mélanger les couleurs primaires pour créer de nouvelles couleurs !",
                bubbleColor: AppColors.purpleAccent,
                maxBubbleWidth: 320,
              ),
              
              Gap(40.h),
              
              // Exemple 4: Avec bouton en dessous
              const Text(
                'Exemple 4: Avec interaction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DynaPuff_SemiCondensed',
                ),
              ),
              Gap(16.h),
              
              Column(
                children: [
                  const MascotWidget(
                    speechText: "Clique sur le bouton pour commencer !",
                    bubbleColor: AppColors.orangeAccent,
                  ),
                  Gap(24.h),
                  CustomButton(
                    label: "Commencer l'aventure",
                    variant: ButtonVariant.primary,
                    size: ButtonSize.lg,
                    width: 250.w,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("L'aventure commence !"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
              
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
