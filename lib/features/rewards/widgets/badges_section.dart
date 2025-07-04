import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/badges/circular_badge.dart';
import 'package:le_petit_davinci/features/rewards/controllers/rewards_controller.dart';
import 'package:le_petit_davinci/features/rewards/widgets/popup_dialog.dart';

class BadgesSection extends GetView<RewardsController> {
  const BadgesSection({
    super.key,
    required this.columns,
    required this.rows,
    required this.badgeVariants,
    required this.unlockedRowsPerColumn,
  });

  final int columns;
  final int rows;
  final List<BadgeVariant> badgeVariants;
  final List<int> unlockedRowsPerColumn;

  @override
  Widget build(BuildContext context) {
    assert(badgeVariants.length == columns);
    assert(unlockedRowsPerColumn.length == columns);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(columns, (colIndex) {
        return Expanded(
          child: SizedBox(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: rows,
              separatorBuilder: (_, _) => const Gap(AppSizes.spaceBtwItems),
              itemBuilder: (context, rowIndex) {
                final unlocked = rowIndex < unlockedRowsPerColumn[colIndex];
                return CircularBadge(
                  variant: badgeVariants[colIndex],
                  unlocked: unlocked,
                  onTap:
                      () => showDialog(
                        context: context,
                        builder:
                            (context) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const PopupDialog(
                                title: 'Maître des additions',
                                description:
                                    'Tu as réussi 10 exercices de calcul mental !',
                                variant: BadgeVariant.dailyLife,
                              ),
                            ),
                      ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
