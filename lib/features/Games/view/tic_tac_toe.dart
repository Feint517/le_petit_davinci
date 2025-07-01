import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/Games/controllers/tic_tac_toe_controller.dart';
import 'package:le_petit_davinci/features/Games/widgets/dialog_winner.dart';
import 'package:le_petit_davinci/features/Games/widgets/tic-tac-toe/game_board.dart';
import 'package:le_petit_davinci/features/Games/widgets/tic-tac-toe/game_controls.dart';
import 'package:le_petit_davinci/features/Games/widgets/tic-tac-toe/mode_selection_popup.dart';
import 'package:le_petit_davinci/features/Games/widgets/tic-tac-toe/progress_section.dart';
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
      body: SafeArea(
        child: Stack(
          children: [
            //* Main game content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  CommonHeader(pageTitle: 'Tic Tac Toe'),
                  const Gap(20),

                  const ProgressSection(),

                  const GameControls(),
                  const Gap(20),

                  const TurnIndicator(),
                  const Gap(20),

                  const GameBoard(),
                ],
              ),
            ),

            // Mode selection popup at the bottom
            Obx(
              () =>
                  controller.showModeSelection.value
                      ? ModeSelectionPopup()
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


//TODO: Fix the issue where the draw screen doesn't show up
class CommonHeader extends StatelessWidget {
  const CommonHeader({
    super.key,
    this.pageTitle,
    this.trailing,
    this.onTapTrailing,
  });

  final String? pageTitle;
  final Widget? trailing;
  final VoidCallback? onTapTrailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                  Text(
                    'Retour',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'BricolageGrotesque',
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child:
                  pageTitle != null
                      ? Text(
                        pageTitle!,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'BricolageGrotesque',
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : const SizedBox.shrink(),
            ),
          ],
        ),
        Spacer(),
        trailing != null
            ? GestureDetector(onTap: onTapTrailing, child: trailing!)
            : const SizedBox.shrink(),
      ],
    );
  }
}
