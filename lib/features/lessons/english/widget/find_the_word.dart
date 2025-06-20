import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/audio/sound_play_button.dart';

class FindTheWord extends StatelessWidget {
  const FindTheWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Sélectionnez l'image qui correspond au son",
          style: TextStyle(color: Colors.white),
        ),
        const Gap(AppSizes.spaceBtwItems),
        const SoundPlayButton(),
        const Gap(AppSizes.spaceBtwSections * 2),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // const ChoiceOption(image: SvgAssets.apple),
            // const ChoiceOption(image: SvgAssets.apple),
            // const ChoiceOption(image: SvgAssets.apple),
          ],
        ),
      ],
    );
  }
}
