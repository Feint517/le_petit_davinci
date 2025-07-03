import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';

class TicTacToeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static TicTacToeController get instance => Get.find();

  //* Game assets
  final txtPlayerO = SvgAssets.o;
  final txtPlayerX = SvgAssets.x;
  final emptyBox = '';

  //* Animation controller for the popup
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  //* Game board
  final xorOList = List.generate(16, (_) => '').obs;


  //* Game state
  final playerO = 0.obs;
  final playerX = 0.obs;
  final equal = 0.obs;
  final filledBoxes = 0.obs;
  final boardSize = 3.obs;
  final aiDifficulty = 'easy'.obs;
  final winnerO = false.obs;
  final winnerX = false.obs;
  final isTurnO = true.obs;
  final isMuted = false.obs;
  final isMultiplayer = false.obs;
  final showModeSelection = true.obs;

  //* Audio player
  final audioPlayer = AudioPlayer();

  @override
  void onInit() {
    super.onInit();

    //* Initialize animation controller
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    //* Create slide animation that moves up from bottom
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), //? Start from below the screen
      end: Offset.zero, //? End at normal position
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linearToEaseOut,
      ),
    );

    //* Start the animation
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    audioPlayer.dispose();
    super.onClose();
  }

  void toggleSound() {
    isMuted(!isMuted.value);
  }

  void startGame() {
    showModeSelection(false);
    playSound('winner.mp3');
  }

  void changeBoardSize(int size) {
    boardSize(size);
  }

  void setMultiplayer(bool value) {
    isMultiplayer(value);
    playSound(value ? 'x.mp3' : 'o.mp3');
  }

  void setDifficulty(String level) {
    aiDifficulty(level);
    playSound('o.mp3');
  }

  Future<void> playSound(String sound) async {
    if (!isMuted.value) {
      await audioPlayer.play(AssetSource('sfx/$sound'));
    }
  }

  void clearGame() {
    for (int i = 0; i < xorOList.length; i++) {
      xorOList[i] = '';
    }
    playerO(0);
    playerX(0);
    filledBoxes(0);
    equal(0);
    winnerO(false);
    winnerX(false);
    isTurnO(true);

    playSound('reset.mp3');

    // Notify UI to update
    update();
  }

  void resetBoard() {
    for (int i = 0; i < xorOList.length; i++) {
      xorOList[i] = '';
    }
    filledBoxes(0);
    winnerO(false);
    winnerX(false);
    isTurnO(true);

    // Notify UI to update
    update();
  }

  void onTilePressed(int index) {
    if (showModeSelection.value) return;

    if (xorOList[index] != emptyBox) return;

    if (isTurnO.value) {
      xorOList[index] = txtPlayerO;
      playSound('o.mp3');
      filledBoxes.value++;
    } else {
      xorOList[index] = txtPlayerX;
      playSound('x.mp3');
      filledBoxes.value++;
    }

    isTurnO(!isTurnO.value);

    checkWinner();

    // If solo mode and it's computer's turn, make AI move after a short delay
    if (!isMultiplayer.value &&
        !isTurnO.value &&
        !winnerO.value &&
        !winnerX.value) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!winnerO.value && !winnerX.value) {
          makeAIMove();
        }
      });
    }

    // Notify UI to update
    update();
  }

  void makeAIMove() {
    if (isMultiplayer.value) return; // Only make AI moves in solo mode

    if (aiDifficulty.value == 'easy') {
      makeEasyAIMove();
    } else if (aiDifficulty.value == 'medium') {
      makeMediumAIMove();
    } else if (aiDifficulty.value == 'hard') {
      makeHardAIMove();
    }
  }

  void makeEasyAIMove() {
    // Find all empty spots
    List<int> emptySpots = [];
    for (int i = 0; i < boardSize.value * boardSize.value; i++) {
      if (xorOList[i] == emptyBox) {
        emptySpots.add(i);
      }
    }

    if (emptySpots.isNotEmpty) {
      // Choose a random empty spot
      emptySpots.shuffle();
      int aiMove = emptySpots.first;

      makeMove(aiMove);
    }
  }

  void makeMediumAIMove() {
    // Reduce randomness to only 10% chance for a random move
    if (Random().nextDouble() < 0.1) {
      makeEasyAIMove();
      return;
    }

    // Find all empty spots
    List<int> emptySpots = [];
    for (int i = 0; i < boardSize.value * boardSize.value; i++) {
      if (xorOList[i] == emptyBox) {
        emptySpots.add(i);
      }
    }

    if (emptySpots.isEmpty) return;

    // Check if AI can win in the next move
    for (int spot in emptySpots) {
      // Simulate placing X at this spot
      xorOList[spot] = txtPlayerX;

      // Check if this would lead to a win
      bool wouldWin = checkWouldWin(txtPlayerX);

      // Undo the simulation
      xorOList[spot] = emptyBox;

      if (wouldWin) {
        // Make the winning move
        makeMove(spot);
        return;
      }
    }

    // Check if player can win in the next move and block
    for (int spot in emptySpots) {
      // Simulate placing O at this spot
      xorOList[spot] = txtPlayerO;

      // Check if this would lead to a win for the player
      bool wouldWin = checkWouldWin(txtPlayerO);

      // Undo the simulation
      xorOList[spot] = emptyBox;

      if (wouldWin) {
        // Block the player's winning move
        makeMove(spot);
        return;
      }
    }

    // Strategic moves for a 3x3 board
    if (boardSize.value == 3) {
      // Try to take center if available
      if (xorOList[4] == emptyBox) {
        makeMove(4);
        return;
      }

      // Try to take corners if available
      List<int> corners = [0, 2, 6, 8];
      corners.shuffle(); // Add some variety

      for (int corner in corners) {
        if (xorOList[corner] == emptyBox) {
          makeMove(corner);
          return;
        }
      }

      // If player has two opposite corners, take a side to prevent a trap
      if ((xorOList[0] == txtPlayerO && xorOList[8] == txtPlayerO) ||
          (xorOList[2] == txtPlayerO && xorOList[6] == txtPlayerO)) {
        // Choose a side
        List<int> sides = [1, 3, 5, 7];
        sides.shuffle();

        for (int side in sides) {
          if (xorOList[side] == emptyBox) {
            makeMove(side);
            return;
          }
        }
      }
    }

    // Strategic moves for a 4x4 board
    if (boardSize.value == 4) {
      // Prioritize the center 2x2 square
      List<int> centerSquare = [5, 6, 9, 10];
      centerSquare.shuffle();

      for (int pos in centerSquare) {
        if (xorOList[pos] == emptyBox) {
          makeMove(pos);
          return;
        }
      }

      // Then try corners
      List<int> corners = [0, 3, 12, 15];
      corners.shuffle();

      for (int corner in corners) {
        if (xorOList[corner] == emptyBox) {
          makeMove(corner);
          return;
        }
      }
    }

    // If we reach here, choose a position that creates a potential winning setup
    // Look for a potential fork (two winning paths)
    Map<int, int> moveScores = {};

    for (int spot in emptySpots) {
      // Place X at this spot
      xorOList[spot] = txtPlayerX;

      // Check how many potential winning lines this creates
      int potentialWins = countPotentialWins(txtPlayerX);
      moveScores[spot] = potentialWins;

      // Undo the move
      xorOList[spot] = emptyBox;
    }

    // Find the move with the highest score
    int bestMove = -1;
    int bestScore = -1;

    moveScores.forEach((spot, score) {
      if (score > bestScore) {
        bestScore = score;
        bestMove = spot;
      }
    });

    if (bestMove != -1 && bestScore > 0) {
      makeMove(bestMove);
      return;
    }

    // If all strategic options failed, just choose randomly
    makeEasyAIMove();
  }

  // Helper function to count the number of potential winning lines
  int countPotentialWins(String player) {
    int count = 0;

    if (boardSize.value == 3) {
      // Check rows
      for (int i = 0; i < 3; i++) {
        int playerCount = 0;
        int emptyCount = 0;

        for (int j = 0; j < 3; j++) {
          if (xorOList[i * 3 + j] == player) {
            playerCount++;
          } else if (xorOList[i * 3 + j] == emptyBox) {
            emptyCount++;
          }
        }

        if (playerCount == 2 && emptyCount == 1) count++;
      }

      // Check columns
      for (int i = 0; i < 3; i++) {
        int playerCount = 0;
        int emptyCount = 0;

        for (int j = 0; j < 3; j++) {
          if (xorOList[j * 3 + i] == player) {
            playerCount++;
          } else if (xorOList[j * 3 + i] == emptyBox) {
            emptyCount++;
          }
        }

        if (playerCount == 2 && emptyCount == 1) count++;
      }

      // Check diagonals
      int diagPlayerCount1 = 0;
      int diagEmptyCount1 = 0;

      for (int i = 0; i < 3; i++) {
        if (xorOList[i * 4] == player) {
          diagPlayerCount1++;
        } else if (xorOList[i * 4] == emptyBox) {
          diagEmptyCount1++;
        }
      }

      if (diagPlayerCount1 == 2 && diagEmptyCount1 == 1) count++;

      int diagPlayerCount2 = 0;
      int diagEmptyCount2 = 0;

      for (int i = 0; i < 3; i++) {
        if (xorOList[(i + 1) * 2] == player) {
          diagPlayerCount2++;
        } else if (xorOList[(i + 1) * 2] == emptyBox) {
          diagEmptyCount2++;
        }
      }

      if (diagPlayerCount2 == 2 && diagEmptyCount2 == 1) count++;
    } else if (boardSize.value == 4) {
      // Simplified for 4x4
      // Check center square potential
      int centerCount = 0;
      int centerEmpty = 0;
      for (int pos in [5, 6, 9, 10]) {
        if (xorOList[pos] == player) {
          centerCount++;
        } else if (xorOList[pos] == emptyBox) {
          centerEmpty++;
        }
      }
      if (centerCount == 3 && centerEmpty == 1) count += 2; // Weighted higher
    }

    return count;
  }

  void makeHardAIMove() {
    // Find all empty spots
    List<int> emptySpots = [];
    for (int i = 0; i < boardSize.value * boardSize.value; i++) {
      if (xorOList[i] == emptyBox) {
        emptySpots.add(i);
      }
    }

    if (emptySpots.isEmpty) return;

    // If it's the first move and we're on a 3x3 board, there's a
    // 20% chance to make a non-optimal move to let the player win sometimes
    if (filledBoxes.value <= 1 &&
        boardSize.value == 3 &&
        Random().nextDouble() < 0.2) {
      makeEasyAIMove();
      return;
    }

    int bestScore = -1000;
    int bestMove = -1;

    // For each empty spot, calculate the minimax score
    for (int spot in emptySpots) {
      // Simulate placing X at this spot
      xorOList[spot] = txtPlayerX;
      filledBoxes.value++;

      // Calculate score from this position
      int score = minimax(0, false);

      // Undo the simulation
      xorOList[spot] = emptyBox;
      filledBoxes.value--;

      if (score > bestScore) {
        bestScore = score;
        bestMove = spot;
      }
    }

    // Make the best move
    if (bestMove != -1) {
      makeMove(bestMove);
    } else {
      // Fallback to random move if something goes wrong
      makeEasyAIMove();
    }
  }

  // Minimax algorithm implementation
  int minimax(int depth, bool isMaximizing) {
    // Check for terminal states
    if (checkWouldWin(txtPlayerX)) {
      return 10 - depth; // AI wins
    }

    if (checkWouldWin(txtPlayerO)) {
      return depth - 10; // Player wins
    }

    // Check for a draw
    if (filledBoxes.value == boardSize.value * boardSize.value) {
      return 0;
    }

    // Find all empty spots
    List<int> emptySpots = [];
    for (int i = 0; i < boardSize.value * boardSize.value; i++) {
      if (xorOList[i] == emptyBox) {
        emptySpots.add(i);
      }
    }

    if (isMaximizing) {
      // AI's turn (X)
      int bestScore = -1000;

      for (int spot in emptySpots) {
        // Simulate placing X at this spot
        xorOList[spot] = txtPlayerX;
        filledBoxes.value++;

        // Calculate score from this position
        int score = minimax(depth + 1, false);

        // Undo the simulation
        xorOList[spot] = emptyBox;
        filledBoxes.value--;

        bestScore = max(score, bestScore);
      }

      return bestScore;
    } else {
      // Player's turn (O)
      int bestScore = 1000;

      for (int spot in emptySpots) {
        // Simulate placing O at this spot
        xorOList[spot] = txtPlayerO;
        filledBoxes.value++;

        // Calculate score from this position
        int score = minimax(depth + 1, true);

        // Undo the simulation
        xorOList[spot] = emptyBox;
        filledBoxes.value--;

        bestScore = min(score, bestScore);
      }

      return bestScore;
    }
  }

  // Helper function to check if the current board state would result in a win
  bool checkWouldWin(String player) {
    if (boardSize.value == 3) {
      // Check rows
      for (int i = 0; i < 3; i++) {
        if (xorOList[i * 3] == player &&
            xorOList[i * 3 + 1] == player &&
            xorOList[i * 3 + 2] == player) {
          return true;
        }
      }

      // Check columns
      for (int i = 0; i < 3; i++) {
        if (xorOList[i] == player &&
            xorOList[i + 3] == player &&
            xorOList[i + 6] == player) {
          return true;
        }
      }

      // Check diagonals
      if (xorOList[0] == player &&
          xorOList[4] == player &&
          xorOList[8] == player) {
        return true;
      }

      if (xorOList[2] == player &&
          xorOList[4] == player &&
          xorOList[6] == player) {
        return true;
      }
    } else if (boardSize.value == 4) {
      // Check rows
      for (int i = 0; i < 4; i++) {
        if (xorOList[i * 4] == player &&
            xorOList[i * 4 + 1] == player &&
            xorOList[i * 4 + 2] == player &&
            xorOList[i * 4 + 3] == player) {
          return true;
        }
      }

      // Check columns
      for (int i = 0; i < 4; i++) {
        if (xorOList[i] == player &&
            xorOList[i + 4] == player &&
            xorOList[i + 8] == player &&
            xorOList[i + 12] == player) {
          return true;
        }
      }

      // Check diagonals
      if (xorOList[0] == player &&
          xorOList[5] == player &&
          xorOList[10] == player &&
          xorOList[15] == player) {
        return true;
      }

      if (xorOList[3] == player &&
          xorOList[6] == player &&
          xorOList[9] == player &&
          xorOList[12] == player) {
        return true;
      }
    }

    return false;
  }

  // Helper function to make a move and handle post-move logic
  void makeMove(int position) {
    xorOList[position] = txtPlayerX;
    playSound('x.mp3');
    filledBoxes.value++;
    isTurnO(true);

    checkWinner();

    // Notify UI to update
    update();
  }

  void checkWinner() {
    if (boardSize.value == 3) {
      // Check all possible winning combinations for 3x3
      _checkWinningCombination(0, 1, 2) ||
          _checkWinningCombination(3, 4, 5) ||
          _checkWinningCombination(6, 7, 8) ||
          _checkWinningCombination(0, 3, 6) ||
          _checkWinningCombination(1, 4, 7) ||
          _checkWinningCombination(2, 5, 8) ||
          _checkWinningCombination(0, 4, 8) ||
          _checkWinningCombination(2, 4, 6);

      // Check for draw
      if (filledBoxes.value == 9 && !winnerO.value && !winnerX.value) {
        equal.value++;
        finishGame();
      }
    } else if (boardSize.value == 4) {
      // Check all possible winning combinations for 4x4
      _checkWinningCombination4x4(0, 1, 2, 3) ||
          _checkWinningCombination4x4(4, 5, 6, 7) ||
          _checkWinningCombination4x4(8, 9, 10, 11) ||
          _checkWinningCombination4x4(12, 13, 14, 15) ||
          _checkWinningCombination4x4(0, 4, 8, 12) ||
          _checkWinningCombination4x4(1, 5, 9, 13) ||
          _checkWinningCombination4x4(2, 6, 10, 14) ||
          _checkWinningCombination4x4(3, 7, 11, 15) ||
          _checkWinningCombination4x4(0, 5, 10, 15) ||
          _checkWinningCombination4x4(3, 6, 9, 12);

      // Check for draw
      if (filledBoxes.value == 16 && !winnerO.value && !winnerX.value) {
        equal.value++;
        finishGame();
      }
    }
  }

  bool _checkWinningCombination(int a, int b, int c) {
    if (xorOList[a] != emptyBox &&
        xorOList[a] == xorOList[b] &&
        xorOList[a] == xorOList[c]) {
      if (xorOList[a] == txtPlayerO) {
        playerO.value++;
        winnerO(true);
        finishGame();
      } else {
        playerX.value++;
        winnerX(true);
        finishGame();
      }
      return true;
    }
    return false;
  }

  bool _checkWinningCombination4x4(int a, int b, int c, int d) {
    if (xorOList[a] != emptyBox &&
        xorOList[a] == xorOList[b] &&
        xorOList[a] == xorOList[c] &&
        xorOList[a] == xorOList[d]) {
      if (xorOList[a] == txtPlayerO) {
        playerO.value++;
        winnerO(true);
        finishGame();
      } else {
        playerX.value++;
        winnerX(true);
        finishGame();
      }
      return true;
    }
    return false;
  }

  void finishGame() {
    Future.delayed(const Duration(seconds: 3), () {
      resetBoard();
    });
  }

  void backToMenu() {
    showModeSelection(true);
    animationController.reset();
    animationController.forward();
  }
}
