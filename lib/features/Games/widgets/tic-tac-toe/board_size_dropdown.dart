import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/Games/controllers/tic_tac_toe_controller.dart';

class BoardSizeDropdown extends GetView<TicTacToeController> {
  const BoardSizeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryDeep,
        border: Border.all(color: AppColors.purple, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(
        () => DropdownButton<String>(
          items: [
            DropdownMenuItem(
              value: '3',
              child: Text(
                '3 x 3',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DropdownMenuItem(
              value: '4',
              child: Text(
                '4 x 4',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              controller.changeBoardSize(int.parse(value));
            }
          },
          dropdownColor: AppColors.primary,
          isExpanded: false,
          value: controller.boardSize.toString(),
          iconSize: 30,
          iconEnabledColor: AppColors.white,
          focusColor: AppColors.primaryDeep,
          borderRadius: BorderRadius.circular(10),
          underline: Container(height: 0),
        ),
      ),
    );
  }
}
