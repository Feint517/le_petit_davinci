import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'dart:math';

import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/Games/widgets/dialog_winner.dart';
import 'package:le_petit_davinci/features/Games/view/tic_tac_toe.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe>
    with SingleTickerProviderStateMixin {
  List xorOList = [
    ImageAssets.emptyBox,
    ImageAssets.emptyBox,
    ImageAssets.emptyBox,
    ImageAssets.emptyBox,
    ImageAssets.emptyBox,
    ImageAssets.emptyBox,
    ImageAssets.emptyBox,
    ImageAssets.emptyBox,
    ImageAssets.emptyBox,
    ImageAssets.emptyBox,
    ImageAssets.emptyBox,
    ImageAssets.emptyBox,
    ImageAssets.emptyBox,
    ImageAssets.emptyBox,
    ImageAssets.emptyBox,
    ImageAssets.emptyBox,
  ];

  final txtPlayerO = ImageAssets.o;
  final txtPlayerX = ImageAssets.x;

  int playerO = 0;
  int playerX = 0;
  int equal = 0;
  int filledBoxes = 0;
  int boardSize = 3;
  String aiDifficulty = 'easy'; // Default difficulty
  bool winnerO = false;
  bool winnerX = false;
  bool isTurnO = true;
  bool isMuted = false;
  bool isMultiplayer = false; // Added for game mode selection
  bool showModeSelection = true; // Control visibility of mode selection

  // Animation controller for the popup
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    // Create slide animation that moves up from bottom
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start from below the screen
      end: Offset(0, 0), // End at normal position
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linearToEaseOut,
      ),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleSound() {
    setState(() {
      isMuted = !isMuted;
    });
  }

  // Hide the mode selection and start the game
  void startGame() {
    setState(() {
      showModeSelection = false;
    });
    playSound('winner.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      body: SafeArea(
        child: Stack(
          children: [
            // Main game content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  CommonHeader(pageTitle: 'Tic Tac Toe'),
                  Gap(20),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Niveau Maitre 🔥',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'BricolageGrotesque',
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '1542',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'BricolageGrotesque',
                              color: AppColors.accent,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: LinearProgressIndicator(
                          value: 0.68, // Replace with your value
                          backgroundColor: Colors.grey,
                          valueColor: AlwaysStoppedAnimation(AppColors.accent),
                          minHeight: 16,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 9, 0, 9),
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: IconButton(
                          icon: Icon(
                            isMuted ? Icons.volume_off : Icons.volume_up,
                            size: 24,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            toggleSound();
                          },
                        ),
                      ),
                      dropDownButton(),
                      GestureDetector(
                        onTap: () {
                          clearGame();
                          playSound('reset.mp3');
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 9, 15, 9),
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.refresh_rounded,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(20),
                  getTurn(),
                  Gap(20),

                  getGridView(),
                ],
              ),
            ),

            // Mode selection popup at the bottom
            if (showModeSelection)
              Positioned(
                bottom: 50, // Bottom padding of 50
                left: 20,
                right: 20,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary,
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sélectionner le mode',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'BricolageGrotesque',
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Solo button
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isMultiplayer = false;
                                  });
                                  playSound('o.mp3');
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.white,
                                      width: 2,
                                    ),
                                    color:
                                        isMultiplayer
                                            ? AppColors.purple
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        isMultiplayer
                                            ? Image.asset(
                                              ImageAssets.ticTacToeOff,
                                              height: 20,
                                              width: 20,
                                            )
                                            : Image.asset(
                                              ImageAssets.ticTacToeOn,
                                              height: 20,
                                              width: 20,
                                            ),
                                        Text(
                                          'Solo',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'BricolageGrotesque',
                                            color:
                                                isMultiplayer
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
                            Gap(20),
                            // Multiplayer button
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isMultiplayer = true;
                                  });
                                  playSound('x.mp3');
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.white,
                                      width: 2,
                                    ),
                                    color:
                                        isMultiplayer
                                            ? AppColors.white
                                            : AppColors.purple,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      isMultiplayer
                                          ? Image.asset(
                                            ImageAssets.ticTacToeOn,
                                            height: 20,
                                            width: 20,
                                          )
                                          : Image.asset(
                                            ImageAssets.ticTacToeOff,
                                            height: 20,
                                            width: 20,
                                          ),
                                      Text(
                                        'Multiplayer',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'BricolageGrotesque',
                                          color:
                                              isMultiplayer
                                                  ? AppColors.purple
                                                  : Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(15),
                        if (!isMultiplayer) // Only show difficulty selector in solo mode
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Difficulté',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'BricolageGrotesque',
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gap(10),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          aiDifficulty = 'easy';
                                        });
                                        playSound('o.mp3');
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.white,
                                            width: 2,
                                          ),
                                          color:
                                              aiDifficulty == 'easy'
                                                  ? Colors.white
                                                  : AppColors.purple,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Facile',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'BricolageGrotesque',
                                              color:
                                                  aiDifficulty == 'easy'
                                                      ? AppColors.purple
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          aiDifficulty = 'medium';
                                        });
                                        playSound('o.mp3');
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.white,
                                            width: 2,
                                          ),
                                          color:
                                              aiDifficulty == 'medium'
                                                  ? Colors.white
                                                  : AppColors.purple,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Moyen',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'BricolageGrotesque',
                                              color:
                                                  aiDifficulty == 'medium'
                                                      ? AppColors.purple
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          aiDifficulty = 'hard';
                                        });
                                        playSound('o.mp3');
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.white,
                                            width: 2,
                                          ),
                                          color:
                                              aiDifficulty == 'hard'
                                                  ? Colors.white
                                                  : AppColors.purple,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Difficile',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'BricolageGrotesque',
                                              color:
                                                  aiDifficulty == 'hard'
                                                      ? AppColors.purple
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(15),
                            ],
                          ),

                        Text(
                          isMultiplayer
                              ? 'Jouez contre un ami!'
                              : 'Jouez contre l\'ordinateur!',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'BricolageGrotesque',
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Bienvenue dans le jeu du Morpion ! Mettez votre logique et votre sens de l’observation à l’épreuve dans ce classique du Tic-Tac-Toe. Affrontez vos amis ou l’ordinateur pour aligner trois symboles consécutifs et remporter la partie. Placez vos X ou O au bon endroit et élaborez la stratégie gagnante !',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'BricolageGrotesque',
                            color: AppColors.white,
                          ),
                        ),
                        Gap(25),
                        Center(
                          child: GestureDetector(
                            onTap: startGame,
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
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'Démarrer le jeu',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'BricolageGrotesque',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
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
              ),
          ],
        ),
      ),
    );
  }

  // 3. Replace the existing makeAIMove function (around line 560) with this updated version
  void makeAIMove() {
    if (isMultiplayer) return; // Only make AI moves in solo mode

    if (aiDifficulty == 'easy') {
      makeEasyAIMove();
    } else if (aiDifficulty == 'medium') {
      makeMediumAIMove();
    } else if (aiDifficulty == 'hard') {
      makeHardAIMove();
    }
  }

  // Original easy mode - completely random moves
  void makeEasyAIMove() {
    // Find all empty spots
    List<int> emptySpots = [];
    for (int i = 0; i < boardSize * boardSize; i++) {
      if (xorOList[i] == ImageAssets.emptyBox) {
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

  // Medium difficulty - can block some wins and make some winning moves
  // Medium difficulty - smarter with less randomness and more strategy
  void makeMediumAIMove() {
    // Reduce randomness to only 10% chance for a random move
    if (Random().nextDouble() < 0.1) {
      makeEasyAIMove();
      return;
    }

    // Find all empty spots
    List<int> emptySpots = [];
    for (int i = 0; i < boardSize * boardSize; i++) {
      if (xorOList[i] == ImageAssets.emptyBox) {
        emptySpots.add(i);
      }
    }

    if (emptySpots.isEmpty) return;

    // Check if AI can win in the next move
    for (int spot in emptySpots) {
      // Simulate placing X at this spot
      xorOList[spot] = ImageAssets.x;

      // Check if this would lead to a win
      bool wouldWin = checkWouldWin(ImageAssets.x);

      // Undo the simulation
      xorOList[spot] = ImageAssets.emptyBox;

      if (wouldWin) {
        // Make the winning move
        makeMove(spot);
        return;
      }
    }

    // Check if player can win in the next move and block
    for (int spot in emptySpots) {
      // Simulate placing O at this spot
      xorOList[spot] = ImageAssets.o;

      // Check if this would lead to a win for the player
      bool wouldWin = checkWouldWin(ImageAssets.o);

      // Undo the simulation
      xorOList[spot] = ImageAssets.emptyBox;

      if (wouldWin) {
        // Block the player's winning move
        makeMove(spot);
        return;
      }
    }

    // Strategic moves for a 3x3 board
    if (boardSize == 3) {
      // Try to take center if available
      if (xorOList[4] == ImageAssets.emptyBox) {
        makeMove(4);
        return;
      }

      // Try to take corners if available
      List<int> corners = [0, 2, 6, 8];
      corners.shuffle(); // Add some variety

      for (int corner in corners) {
        if (xorOList[corner] == ImageAssets.emptyBox) {
          makeMove(corner);
          return;
        }
      }

      // If player has two opposite corners, take a side to prevent a trap
      if ((xorOList[0] == ImageAssets.o && xorOList[8] == ImageAssets.o) ||
          (xorOList[2] == ImageAssets.o && xorOList[6] == ImageAssets.o)) {
        // Choose a side
        List<int> sides = [1, 3, 5, 7];
        sides.shuffle();

        for (int side in sides) {
          if (xorOList[side] == ImageAssets.emptyBox) {
            makeMove(side);
            return;
          }
        }
      }
    }

    // Strategic moves for a 4x4 board
    if (boardSize == 4) {
      // Prioritize the center 2x2 square
      List<int> centerSquare = [5, 6, 9, 10];
      centerSquare.shuffle();

      for (int pos in centerSquare) {
        if (xorOList[pos] == ImageAssets.emptyBox) {
          makeMove(pos);
          return;
        }
      }

      // Then try corners
      List<int> corners = [0, 3, 12, 15];
      corners.shuffle();

      for (int corner in corners) {
        if (xorOList[corner] == ImageAssets.emptyBox) {
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
      xorOList[spot] = ImageAssets.x;

      // Check how many potential winning lines this creates
      int potentialWins = countPotentialWins(ImageAssets.x);
      moveScores[spot] = potentialWins;

      // Undo the move
      xorOList[spot] = ImageAssets.emptyBox;
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

    if (boardSize == 3) {
      // Check rows
      for (int i = 0; i < 3; i++) {
        int playerCount = 0;
        int emptyCount = 0;

        for (int j = 0; j < 3; j++) {
          if (xorOList[i * 3 + j] == player) {
            playerCount++;
          } else if (xorOList[i * 3 + j] == ImageAssets.emptyBox) {
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
          } else if (xorOList[j * 3 + i] == ImageAssets.emptyBox) {
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
        } else if (xorOList[i * 4] == ImageAssets.emptyBox) {
          diagEmptyCount1++;
        }
      }

      if (diagPlayerCount1 == 2 && diagEmptyCount1 == 1) count++;

      int diagPlayerCount2 = 0;
      int diagEmptyCount2 = 0;

      for (int i = 0; i < 3; i++) {
        if (xorOList[(i + 1) * 2] == player) {
          diagPlayerCount2++;
        } else if (xorOList[(i + 1) * 2] == ImageAssets.emptyBox) {
          diagEmptyCount2++;
        }
      }

      if (diagPlayerCount2 == 2 && diagEmptyCount2 == 1) count++;
    } else if (boardSize == 4) {
      // Similar logic for 4x4 but with longer winning patterns
      // This would be much longer code, so simplified for brevity
      // Check a few key patterns for 4x4

      // Check center square potential
      int centerCount = 0;
      int centerEmpty = 0;
      for (int pos in [5, 6, 9, 10]) {
        if (xorOList[pos] == player) {
          centerCount++;
        } else if (xorOList[pos] == ImageAssets.emptyBox) {
          centerEmpty++;
        }
      }
      if (centerCount == 3 && centerEmpty == 1) count += 2; // Weighted higher
    }

    return count;
  }

  // Hard difficulty - uses minimax algorithm for optimal play
  void makeHardAIMove() {
    // Find all empty spots
    List<int> emptySpots = [];
    for (int i = 0; i < boardSize * boardSize; i++) {
      if (xorOList[i] == ImageAssets.emptyBox) {
        emptySpots.add(i);
      }
    }

    if (emptySpots.isEmpty) return;

    // If it's the first move and we're on a 3x3 board, there's a
    // 20% chance to make a non-optimal move to let the player win sometimes
    if (filledBoxes <= 1 && boardSize == 3 && Random().nextDouble() < 0.2) {
      makeEasyAIMove();
      return;
    }

    int bestScore = -1000;
    int bestMove = -1;

    // For each empty spot, calculate the minimax score
    for (int spot in emptySpots) {
      // Simulate placing X at this spot
      xorOList[spot] = ImageAssets.x;
      filledBoxes++;

      // Calculate score from this position
      int score = minimax(0, false);

      // Undo the simulation
      xorOList[spot] = ImageAssets.emptyBox;
      filledBoxes--;

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
    if (checkWouldWin(ImageAssets.x)) {
      return 10 - depth; // AI wins
    }

    if (checkWouldWin(ImageAssets.o)) {
      return depth - 10; // Player wins
    }

    // Check for a draw
    if (filledBoxes == boardSize * boardSize) {
      return 0;
    }

    // Find all empty spots
    List<int> emptySpots = [];
    for (int i = 0; i < boardSize * boardSize; i++) {
      if (xorOList[i] == ImageAssets.emptyBox) {
        emptySpots.add(i);
      }
    }

    if (isMaximizing) {
      // AI's turn (X)
      int bestScore = -1000;

      for (int spot in emptySpots) {
        // Simulate placing X at this spot
        xorOList[spot] = ImageAssets.x;
        filledBoxes++;

        // Calculate score from this position
        int score = minimax(depth + 1, false);

        // Undo the simulation
        xorOList[spot] = ImageAssets.emptyBox;
        filledBoxes--;

        bestScore = max(score, bestScore);
      }

      return bestScore;
    } else {
      // Player's turn (O)
      int bestScore = 1000;

      for (int spot in emptySpots) {
        // Simulate placing O at this spot
        xorOList[spot] = ImageAssets.o;
        filledBoxes++;

        // Calculate score from this position
        int score = minimax(depth + 1, true);

        // Undo the simulation
        xorOList[spot] = ImageAssets.emptyBox;
        filledBoxes--;

        bestScore = min(score, bestScore);
      }

      return bestScore;
    }
  }

  // Helper function to check if the current board state would result in a win
  bool checkWouldWin(String player) {
    if (boardSize == 3) {
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
    } else if (boardSize == 4) {
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
    setState(() {
      xorOList[position] = ImageAssets.x;
      playSound('x.mp3');
      filledBoxes = filledBoxes + 1;
      isTurnO = true;

      checkWinner();

      if (winnerX == true) {
        playSound('winner.mp3');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return GameOverDialog(
              onPlayAgain: () {
                Navigator.pop(context);
                clearGame();
                playSound('reset.mp3');
              },
              onMenu: () {
                showModeSelection = true;
                Navigator.pop(context);
              },
            );
          },
        );
      }

      if ((boardSize == 3 && filledBoxes == 9 ||
              boardSize == 4 && filledBoxes == 16) &&
          winnerO == false &&
          winnerX == false) {
        playSound('equal.wav');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CongratulationsDialogEqual(onPressed: () {});
          },
        );
      }
    });
  }

  Widget dropDownButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryDeep,
        border: Border.all(color: AppColors.purple, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
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
          setState(() {
            boardSize = int.parse(value!);
          });
        },

        dropdownColor: AppColors.primaryDeep,
        isExpanded: false,
        value: boardSize.toString(),
        iconSize: 30,
        iconEnabledColor: AppColors.white,
        focusColor: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
        underline: Container(height: 0),
      ),
    );
  }

  Widget getTurn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isTurnO ? 'Tour du joueur' : ' Tour du joueur ',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.secondary,
            fontFamily: 'BricolageGrotesque',
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(5),
        Image.asset(
          isTurnO ? ImageAssets.o : ImageAssets.blackX,
          height: 30,
          width: 30,
        ),
      ],
    );
  }

  Widget getGridView() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
        child: GridView.builder(
          // shrinkWrap: true,
          itemCount: boardSize * boardSize,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: boardSize,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                if (showModeSelection) {
                  return; // Don't allow moves when mode selection is shown
                }

                setState(() {
                  if (xorOList[index] != ImageAssets.emptyBox) {
                    return;
                  }
                  if (isTurnO) {
                    xorOList[index] = ImageAssets.o;
                    playSound('o.mp3');
                    filledBoxes = filledBoxes + 1;
                  } else {
                    xorOList[index] = ImageAssets.x;
                    playSound('x.mp3');
                    filledBoxes = filledBoxes + 1;
                  }
                  isTurnO = !isTurnO;

                  checkWinner();

                  // If solo mode and it's computer's turn, make AI move after a short delay
                  if (!isMultiplayer && !isTurnO && !winnerO && !winnerX) {
                    Future.delayed(Duration(milliseconds: 500), () {
                      if (!winnerO && !winnerX) {
                        makeAIMove();
                      }
                    });
                  }

                  if (winnerO == true) {
                    playSound('winner.mp3');
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CongratulationsDialog(onPressed: () {});
                      },
                    );
                  }

                  if (winnerX == true) {
                    playSound('winner.mp3');
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return GameOverDialog(
                          onPlayAgain: () {},
                          onMenu: () {},
                        );
                      },
                    );
                  }

                  if (boardSize == 3) {
                    if (filledBoxes == 9 &&
                        winnerO == false &&
                        winnerX == false) {
                      playSound('equal.wav');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CongratulationsDialogEqual(onPressed: () {});
                        },
                      );
                    }
                  }

                  if (boardSize == 4) {
                    if (filledBoxes == 16 &&
                        winnerO == false &&
                        winnerX == false) {
                      playSound('equal.wav');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CongratulationsDialogEqual(onPressed: () {});
                        },
                      );
                    }
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(image: AssetImage(xorOList[index])),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void checkWinner() {
    if (boardSize == 3) {
      if (xorOList[0] == xorOList[1] &&
          xorOList[0] == xorOList[2] &&
          xorOList[0] != ImageAssets.emptyBox) {
        if (xorOList[0] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[3] == xorOList[4] &&
          xorOList[3] == xorOList[5] &&
          xorOList[3] != ImageAssets.emptyBox) {
        if (xorOList[3] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[6] == xorOList[7] &&
          xorOList[6] == xorOList[8] &&
          xorOList[6] != ImageAssets.emptyBox) {
        if (xorOList[6] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[0] == xorOList[3] &&
          xorOList[0] == xorOList[6] &&
          xorOList[0] != ImageAssets.emptyBox) {
        if (xorOList[0] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[1] == xorOList[4] &&
          xorOList[1] == xorOList[7] &&
          xorOList[1] != ImageAssets.emptyBox) {
        if (xorOList[1] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[2] == xorOList[5] &&
          xorOList[8] == xorOList[2] &&
          xorOList[2] != ImageAssets.emptyBox) {
        if (xorOList[2] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[0] == xorOList[4] &&
          xorOList[0] == xorOList[8] &&
          xorOList[0] != ImageAssets.emptyBox) {
        if (xorOList[0] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[2] == xorOList[4] &&
          xorOList[2] == xorOList[6] &&
          xorOList[2] != ImageAssets.emptyBox) {
        if (xorOList[2] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (filledBoxes == 9) {
        equal = equal + 1;
        finishGame();
        return;
      }
    }
    if (boardSize == 4) {
      if (xorOList[0] == xorOList[4] &&
          xorOList[0] == xorOList[8] &&
          xorOList[0] == xorOList[12] &&
          xorOList[0] != ImageAssets.emptyBox) {
        if (xorOList[0] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[1] == xorOList[5] &&
          xorOList[1] == xorOList[9] &&
          xorOList[1] == xorOList[13] &&
          xorOList[1] != ImageAssets.emptyBox) {
        if (xorOList[1] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[2] == xorOList[6] &&
          xorOList[2] == xorOList[10] &&
          xorOList[2] == xorOList[14] &&
          xorOList[2] != ImageAssets.emptyBox) {
        if (xorOList[2] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[3] == xorOList[7] &&
          xorOList[3] == xorOList[11] &&
          xorOList[3] == xorOList[15] &&
          xorOList[3] != ImageAssets.emptyBox) {
        if (xorOList[3] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[0] == xorOList[1] &&
          xorOList[0] == xorOList[2] &&
          xorOList[0] == xorOList[3] &&
          xorOList[0] != ImageAssets.emptyBox) {
        if (xorOList[0] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[4] == xorOList[5] &&
          xorOList[4] == xorOList[6] &&
          xorOList[4] == xorOList[7] &&
          xorOList[4] != ImageAssets.emptyBox) {
        if (xorOList[4] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[8] == xorOList[9] &&
          xorOList[8] == xorOList[10] &&
          xorOList[8] == xorOList[11] &&
          xorOList[8] != ImageAssets.emptyBox) {
        if (xorOList[8] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[12] == xorOList[13] &&
          xorOList[12] == xorOList[14] &&
          xorOList[12] == xorOList[15] &&
          xorOList[12] != ImageAssets.emptyBox) {
        if (xorOList[12] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[0] == xorOList[5] &&
          xorOList[0] == xorOList[10] &&
          xorOList[0] == xorOList[15] &&
          xorOList[0] != ImageAssets.emptyBox) {
        if (xorOList[0] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (xorOList[3] == xorOList[6] &&
          xorOList[3] == xorOList[9] &&
          xorOList[3] == xorOList[12] &&
          xorOList[3] != ImageAssets.emptyBox) {
        if (xorOList[3] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        } else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if (filledBoxes == 16) {
        equal = equal + 1;
        finishGame();
        return;
      }
    }
  }

  void finishGame() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        for (int i = 0; i < xorOList.length; i++) {
          xorOList[i] = ImageAssets.emptyBox;
          filledBoxes = 0;
          winnerO = false;
          winnerX = false;
          isTurnO = true;
        }
      });
    });
  }

  void clearGame() {
    setState(() {
      for (int i = 0; i < xorOList.length; i++) {
        xorOList[i] = ImageAssets.emptyBox;
      }
      playerO = 0;
      playerX = 0;
      filledBoxes = 0;
      equal = 0;
      winnerO = false;
      winnerX = false;
      isTurnO = true;
    });
  }

  playSound(sound) {
    final player = AudioPlayer();
    if (isMuted) {
      Null;
    } else {
      player.play(AssetSource('sfx/$sound'));
    }
  }
}
