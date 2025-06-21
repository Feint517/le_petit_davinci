import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';
import 'package:le_petit_davinci/features/french/widgets/lesson_tile.dart';

class FrenchLessons extends StatelessWidget {
  const FrenchLessons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluePrimary,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.defaultSpace,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                const CustomNavBar(),
                Text(
                  "Matériel d'apprentissage",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const Column(
                  spacing: AppSizes.spaceBtwItems,
                  children: [
                    LessonTile(title: '1- Le déterminant'),
                    LessonTile(title: '2- Comment identifier un déterminant ?'),
                    LessonTile(title: '3- Le pronom'),
                    LessonTile(title: '4- Comment identifier un adjectif ?'),
                    LessonTile(title: '5- Le verbe'),
                    LessonTile(title: '6- Le groupe du nom'),
                    LessonTile(title: '7- Comment identifier un nom ?'),
                    LessonTile(title: '8- Le nom commun et le nom propre'),
                    LessonTile(title: '9- Survoler le texte'),
                    LessonTile(title: '10- Activer mes connaissances'),
                    LessonTile(title: '11- Résumer le texte'),
                    LessonTile(
                      title: '12- Identifier les informations importantes',
                    ),
                    LessonTile(
                      title: '13- Identifier mon intention de lecture',
                    ),
                    LessonTile(title: '14- Me faire une image'),
                    LessonTile(title: '15- Tenir compte de la ponctuation'),
                    LessonTile(title: '16- Relire'),
                  ],
                ),
                const Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


