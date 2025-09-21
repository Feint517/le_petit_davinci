import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/features/exercises/models/story/story_element_model.dart';
import 'package:le_petit_davinci/features/levels/models/story_element_model.dart';

class DialogueLineView extends StatelessWidget {
  const DialogueLineView({super.key, required this.dialogue});

  final DialogueLine dialogue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ResponsiveImageAsset(
            assetPath: dialogue.avatarAsset,
            width: 50,
            height: 58,
          ),
          const Gap(AppSizes.sm),
          Expanded(
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(AppSizes.md),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    dialogue.characterName,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(AppSizes.xs),
                  Text(
                    dialogue.text,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
