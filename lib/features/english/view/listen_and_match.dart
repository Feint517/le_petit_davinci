import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/audio/sound_play_button.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/custom_shapes/container/curved_header_container.dart';
import 'package:le_petit_davinci/core/widgets/misc/mascot_widget_old.dart';
import 'package:le_petit_davinci/features/english/controllers/listen_and_match_controller.dart';
import 'package:le_petit_davinci/features/lessons/english/widget/choice_option.dart';
import 'package:le_petit_davinci/features/lessons/english/widget/practice_header.dart';

class ListenAndMatch extends StatelessWidget {
  const ListenAndMatch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListenAndMatchController());
    return Scaffold(
      backgroundColor: AppColors.accent,
      floatingActionButton: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child:
              controller.isChecked.value
                  ? FloatingActionButton(
                    key: const ValueKey('fab'),
                    onPressed: () {
                      if (controller.isCorrect.value == true) {
                        controller.nextQuestion();
                      } else {
                        controller.isChecked.value = false;
                        controller.isCorrect.value = null;
                      }
                    },
                    backgroundColor:
                        controller.isCorrect.value == true
                            ? Colors.green
                            : Colors.red,
                    child: Icon(
                      controller.isCorrect.value == true
                          ? Icons.arrow_forward
                          : Icons.refresh,
                      color: AppColors.accentDark,
                    ),
                  )
                  : const SizedBox.shrink(key: ValueKey('empty')),
        ),
      ),
      body: SingleChildScrollView(
        primary: true,
        child: SizedBox(
          height: DeviceUtils.getScreenHeight(),
          //? we wrapped the stack with SizedBox because because in a scroll view, the Stack takes only the height of its children
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              CustomCurvedHeaderContainer(
                child: PracticeHeader(
                  lessonName: 'Listen & Match',
                  lessonDescription:
                      'Associer un mot entendu à son image correspondante.',
                  badgeVariant: BadgeVariant.english,
                  badgeType: LessonBadgeType.soundMaster,
                ),
              ),
              Positioned(
                top: 400 - 80,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Obx(() {
                      final item =
                          controller.items[controller.currentIndex.value];
                      final selected = controller.selectedOption.value;
                      final checked = controller.isChecked.value;
                      return Column(
                        children: [
                          const Text(
                            "Sélectionnez l'image qui correspond au son",
                            style: TextStyle(color: Colors.white),
                          ),
                          const Gap(AppSizes.spaceBtwItems),
                          SoundPlayButton(onTap: controller.playAudio),
                          const Gap(AppSizes.spaceBtwSections * 2),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ...List.generate(item.options.length, (index) {
                                bool isCorrect =
                                    checked && index == item.correctIndex;
                                bool isWrong =
                                    checked &&
                                    selected == index &&
                                    selected != item.correctIndex;
                                bool isSelected = selected == index;
                                return ChoiceOption(
                                  image: item.options[index],
                                  isSelected: isSelected,
                                  isCorrect: isCorrect,
                                  isWrong: isWrong,
                                  onTap: () {
                                    controller.selectOption(index);
                                  },
                                );
                              }),
                            ],
                          ),
                        ],
                      );
                    }),
                    Gap(24),
                    CustomButton(
                      label: 'Check',
                      variant: ButtonVariant.secondary,
                      size: ButtonSize.md,
                      width: 150,
                      onPressed: () => controller.checkAnswer(),
                    ),
                  ],
                ),
              ),
              // Mascot feedback at the bottom
              Obx(() {
                if (!controller.isChecked.value) return SizedBox.shrink();
                return AnimatedSlide(
                  offset:
                      controller.isChecked.value ? Offset(0, 0) : Offset(0, 1),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MascotWidget(
                      speechText: controller.feedbackMessage,
                      assetPath:
                          controller.isCorrect.value == true
                              ? SvgAssets.bearMasscot
                              : SvgAssets.happyCat,
                      // You can add more customization here
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
