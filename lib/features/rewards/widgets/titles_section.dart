import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/features/rewards/controllers/rewards_controller.dart';
import 'package:le_petit_davinci/features/rewards/widgets/title_display.dart';

class TitlesSection extends GetView<RewardsController> {
  const TitlesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSizes.spaceBtwSections,
      children: [
        const TitleDisplay(
          variant: BadgeVariant.french,
          title: 'Explorateur des mots',
          message: 'Encore 2 activités pour atteindre : Maître du langage !',
          currentLevel: 2,
          totalLevels: 5,
        ),
        const TitleDisplay(
          variant: BadgeVariant.math,
          title: 'Génie du calcul',
          message: 'Encore 2 activités pour atteindre : Maître du langage !',
          currentLevel: 2,
          totalLevels: 5,
        ),
        const TitleDisplay(
          variant: BadgeVariant.english,
          title: 'Maître du langage',
          message: 'Encore 2 activités pour atteindre : Maître du langage !',
          currentLevel: 2,
          totalLevels: 5,
        ),
        const TitleDisplay(
          variant: BadgeVariant.dailyLife,
          title: 'Aventurier du quotidien',
          message: 'Encore 2 activités pour atteindre : Maître du langage !',
          currentLevel: 2,
          totalLevels: 5,
        ),
      ],
    );
  }
}
