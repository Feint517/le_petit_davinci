import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/features/lessons/widget/choice_option.dart';
import 'package:le_petit_davinci/features/lessons/widget/icon_square.dart';

class ListenAndMatch extends StatelessWidget {
  const ListenAndMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Sélectionnez l'image qui correspond au son",
          style: TextStyle(color: Colors.white),
        ),
        const Gap(AppSizes.spaceBtwItems),
        const IconSquare(),
        const Gap(AppSizes.spaceBtwSections * 2),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const ChoiceOption(image: SvgAssets.apple),
            const ChoiceOption(image: SvgAssets.igloo),
            const ChoiceOption(image: SvgAssets.octopus),
          ],
        ),
      ],
    );
  }
}
