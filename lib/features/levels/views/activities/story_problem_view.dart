import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/features/levels/models/activities/story_problem_activity.dart';
import 'package:le_petit_davinci/features/levels/models/draggable_item_model.dart';
import 'package:le_petit_davinci/features/levels/widgets/item_widget.dart';

class StoryProblemView extends StatelessWidget {
  const StoryProblemView({super.key, required this.activity});

  final StoryProblemActivity activity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. The Story/Dialogue
        Text(
          activity.instruction,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const Gap(AppSizes.spaceBtwSections),

        // 2. The Drop Zone (DragTarget)
        DragTarget<DraggableItem>(
          onAcceptWithDetails: (details) {
            activity.addItem(details.data);
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.md),
              decoration: BoxDecoration(
                color:
                    candidateData.isNotEmpty
                        ? AppColors.secondary.withValues(alpha: 0.2)
                        : AppColors.lightGrey.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
                border: Border.all(
                  color:
                      candidateData.isNotEmpty
                          ? AppColors.secondary
                          : AppColors.grey,
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Obx(
                () => Wrap(
                  alignment: WrapAlignment.center,
                  spacing: AppSizes.sm,
                  runSpacing: AppSizes.sm,
                  children:
                      activity.droppedItems.map((item) {
                        // Allow tapping an item in the drop zone to remove it
                        return GestureDetector(
                          onTap: () => activity.removeItem(item),
                          child: ItemWidget(
                            assetPath: item.imageAsset!,
                            value: item.value,
                          ),
                        );
                      }).toList(),
                ),
              ),
            );
          },
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: AppSizes.spaceBtwItems,
            runSpacing: AppSizes.spaceBtwItems,
            children:
                activity.draggableOptions.map((item) {
                  return Draggable<DraggableItem>(
                    data: item,
                    // The feedback widget is what's shown while dragging
                    feedback: ItemWidget(
                      assetPath: item.imageAsset!,
                      value: item.value,
                      height: 60,
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.5,
                      child: ItemWidget(
                        assetPath: item.imageAsset!,
                        value: item.value,
                      ),
                    ),
                    child: ItemWidget(
                      assetPath: item.imageAsset!,
                      value: item.value,
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
