import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/Games/controllers/tic_tac_toe_controller.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
        child: GetBuilder<TicTacToeController>(
          builder: (ctrl) => GridView.builder(
            itemCount: ctrl.boardSize.value * ctrl.boardSize.value,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ctrl.boardSize.value,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => ctrl.onTilePressed(index),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(image: AssetImage(ctrl.xorOList[index])),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}