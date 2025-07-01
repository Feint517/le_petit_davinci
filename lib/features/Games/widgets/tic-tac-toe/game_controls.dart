import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/Games/controllers/tic_tac_toe_controller.dart';
import 'package:le_petit_davinci/features/Games/widgets/tic-tac-toe/board_size_dropdown.dart';

class GameControls extends GetView<TicTacToeController> {
  const GameControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Sound toggle button
        Container(
          margin: const EdgeInsets.fromLTRB(15, 9, 0, 9),
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Obx(() => IconButton(
              icon: Icon(
                controller.isMuted.value ? Icons.volume_off : Icons.volume_up,
                size: 24,
                color: Colors.white,
              ),
              onPressed: controller.toggleSound,
            ),
          ),
        ),
        
        const BoardSizeDropdown(),
        
        //* Reset button
        GestureDetector(
          onTap: controller.clearGame,
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 9, 15, 9),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.refresh_rounded,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}