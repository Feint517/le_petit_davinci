import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/state_manager.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/Games/controllers/tic_tac_toe_controller.dart';

class TurnIndicator extends GetView<TicTacToeController> {
  const TurnIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.isTurnO.value ? 'Tour du joueur' : ' Tour du joueur ',
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.secondary,
              fontFamily: 'BricolageGrotesque',
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(5),
          Image.asset(
            controller.isTurnO.value ? ImageAssets.o : ImageAssets.blackX,
            height: 30,
            width: 30,
          ),
        ],
      ),
    );
  }
}
