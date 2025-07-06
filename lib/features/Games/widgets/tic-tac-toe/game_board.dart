import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/features/Games/controllers/tic_tac_toe_controller.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
        child: GetBuilder<TicTacToeController>(
          builder:
              (controller) => GridView.builder(
                itemCount:
                    controller.boardSize.value * controller.boardSize.value,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: controller.boardSize.value,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => controller.onTilePressed(index),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSizes.sm),
                        child:
                            controller.xorOList[index] == controller.emptyBox
                                ? null
                                : ResponsiveImageAsset(
                                  assetPath: controller.xorOList[index],
                                  width: 30,
                                ),
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
