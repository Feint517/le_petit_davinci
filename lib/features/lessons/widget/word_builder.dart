import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/audio/sound_play_button.dart';
import 'package:le_petit_davinci/features/lessons/widget/letter_choice.dart';

class WordBuilder extends StatelessWidget {
  const WordBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Glisser chaque lettre dans des emplacements vides",
          style: TextStyle(color: Colors.white),
        ),
        const Gap(AppSizes.spaceBtwItems),
        const SoundPlayButton(),
        const Gap(AppSizes.spaceBtwSections * 2),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LetterChoice(letter: 'e'),
            LetterChoice(letter: 'u'),
            LetterChoice(letter: 'h'),
            LetterChoice(letter: 'o'),
            LetterChoice(letter: 's'),
          ],
        ),
      ],
    );
  }
}
