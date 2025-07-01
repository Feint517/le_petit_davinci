import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/state_manager.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/Games/controllers/tic_tac_toe_controller.dart';
import 'package:le_petit_davinci/features/Games/widgets/tic-tac-toe/difficulty_button.dart';

class ModeSelectionPopup extends GetView<TicTacToeController> {
  const ModeSelectionPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 20,
      right: 20,
      child: SlideTransition(
        position: controller.slideAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.purple,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary,
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sélectionner le mode',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'BricolageGrotesque',
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Solo button
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.setMultiplayer(false),
                      child: Obx(
                        () => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.white,
                              width: 2,
                            ),
                            color:
                                controller.isMultiplayer.value
                                    ? AppColors.purple
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  controller.isMultiplayer.value
                                      ? ImageAssets.ticTacToeOff
                                      : ImageAssets.ticTacToeOn,
                                  height: 20,
                                  width: 20,
                                ),
                                Text(
                                  'Solo',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'BricolageGrotesque',
                                    color:
                                        controller.isMultiplayer.value
                                            ? AppColors.white
                                            : AppColors.purple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  // Multiplayer button
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.setMultiplayer(true),
                      child: Obx(
                        () => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.white,
                              width: 2,
                            ),
                            color:
                                controller.isMultiplayer.value
                                    ? AppColors.white
                                    : AppColors.purple,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                controller.isMultiplayer.value
                                    ? ImageAssets.ticTacToeOn
                                    : ImageAssets.ticTacToeOff,
                                height: 20,
                                width: 20,
                              ),
                              Text(
                                'Multiplayer',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'BricolageGrotesque',
                                  color:
                                      controller.isMultiplayer.value
                                          ? AppColors.purple
                                          : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(15),

              // Only show difficulty selector in solo mode
              Obx(
                () =>
                    !controller.isMultiplayer.value
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Difficulté',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'BricolageGrotesque',
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(10),
                            const Row(
                              children: [
                                DifficultyButton('easy', 'Facile'),
                                Gap(10),
                                DifficultyButton('medium', 'Moyen'),
                                Gap(10),
                                DifficultyButton('hard', 'Difficile'),
                              ],
                            ),
                            const Gap(15),
                          ],
                        )
                        : const SizedBox(),
              ),

              Obx(
                () => Text(
                  controller.isMultiplayer.value
                      ? 'Jouez contre un ami!'
                      : 'Jouez contre l\'ordinateur!',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'BricolageGrotesque',
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                "Bienvenue dans le jeu du Morpion ! Mettez votre logique et votre sens de l'observation à l'épreuve dans ce classique du Tic-Tac-Toe. Affrontez vos amis ou l'ordinateur pour aligner trois symboles consécutifs et remporter la partie. Placez vos X ou O au bon endroit et élaborez la stratégie gagnante !",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'BricolageGrotesque',
                  color: AppColors.white,
                ),
              ),
              const Gap(25),
              Center(
                child: GestureDetector(
                  onTap: controller.startGame,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.accent3,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondary.withValues(
                            alpha: 0.3,
                          ),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Démarrer le jeu',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'BricolageGrotesque',
                            color: Colors.black,
                          ),
                        ),
                        Gap(8),
                        Icon(
                          Icons.play_arrow_outlined,
                          color: Colors.black,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
