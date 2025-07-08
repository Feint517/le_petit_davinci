import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/Games/controllers/tic_tac_toe_controller.dart';
import 'package:le_petit_davinci/features/Games/widgets/dialog_winner.dart';
import 'package:le_petit_davinci/features/Games/widgets/tic-tac-toe/game_board.dart';
import 'package:le_petit_davinci/features/Games/widgets/tic-tac-toe/game_controls.dart';
import 'package:le_petit_davinci/features/Games/widgets/tic-tac-toe/mode_selection_popup.dart';
import 'package:le_petit_davinci/features/Games/widgets/tic-tac-toe/turn_indicator.dart';

class TicTacToe extends GetView<TicTacToeController> {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TicTacToeController());

    //* Listen for winner state changes
    ever(controller.winnerO, (isWinner) {
      if (isWinner) {
        controller.playSound('winner.mp3');
        _showWinnerDialog(context, controller);
      }
    });

    ever(controller.winnerX, (isWinner) {
      if (isWinner) {
        controller.playSound('winner.mp3');
        _showGameOverDialog(context, controller);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: ProfileHeader(showTrailingIcon: false),
      body: SafeArea(
        child: Stack(
          children: [
            //* Main game content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  const GameControls(),
                  const Gap(20),

                  const TurnIndicator(),
                  const Gap(20),

                  const GameBoard(),
                ],
              ),
            ),

            //* Mode selection popup at the bottom
            Obx(
              () =>
                  controller.showModeSelection.value
                      ? const ModeSelectionPopup()
                      : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

void _showWinnerDialog(BuildContext context, TicTacToeController controller) {
  showDialog(
    context: context,
    builder:
        (context) => CongratulationsDialog(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
  );
}

void _showGameOverDialog(BuildContext context, TicTacToeController controller) {
  showDialog(
    context: context,
    builder:
        (context) => GameOverDialog(
          onPlayAgain: () {
            Navigator.pop(context);
            controller.clearGame();
          },
          onMenu: () {
            Navigator.pop(context);
            controller.backToMenu();
          },
        ),
  );
}

void _showDrawDialog(BuildContext context, TicTacToeController controller) {
  showDialog(
    context: context,
    builder:
        (context) => CongratulationsDialogEqual(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
  );
}
