import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/activity_display.dart';
import 'package:le_petit_davinci/features/home/widgets/section_heading.dart';

class ActivitiesSection extends StatelessWidget {
  const ActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(sectionName: "Dernières activités"),
        const Gap(AppSizes.spaceBtwItems),
        ActivityDisplay(
          variant: BadgeVariant.french,
          status: ActivityStatus.completed,
          title: 'Dictée magique',
          stat: '2/3 bonnes réponses',
          activityTime: DateTime(2024, 5, 12, 10, 20),
        ),
        const Gap(AppSizes.spaceBtwItems),
        ActivityDisplay(
          variant: BadgeVariant.english,
          status: ActivityStatus.started,
          title: 'Les soustractions en mission',
          stat: '2/3 bonnes réponses',
          activityTime: DateTime(2024, 5, 12, 10, 20),
        ),
        const Gap(AppSizes.spaceBtwItems),
        ActivityDisplay(
          variant: BadgeVariant.games,
          status: ActivityStatus.completed,
          title: 'Dictée magique',
          stat: '2/3 bonnes réponses',
          activityTime: DateTime(5, 12, 10, 20),
        ),
        const Gap(AppSizes.spaceBtwItems),

        CustomButton(
          label: 'Voir Tous',
          variant: ButtonVariant.secondary,
          width: 120,
          onPressed: () {
            //TODO: imlpemet see all functionality
          },
        ),
      ],
    );
  }
}
