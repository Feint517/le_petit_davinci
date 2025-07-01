import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/Games/view/tic_tac_toe.dart';

class SnakeGame extends StatefulWidget {
  const SnakeGame({super.key});

  @override
  State<SnakeGame> createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> with TickerProviderStateMixin {
  // Constants
  static const int squaresPerRow = 20;
  static const int squaresPerCol = 18;

  // Animation controller for the popup
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  // Additional animations
  late AnimationController _snakeHeadAnimController;
  late AnimationController _appleAnimController;
  late AnimationController _backgroundAnimController;
  late Animation<Color?> _backgroundColorAnimation;

  AudioPlayer audioPlayer = AudioPlayer();
  bool isMuted = false;
  bool showModeSelection = true;
  String difficulty = 'medium';

  // Game state
  late List<int> snake; // Will be initialized in initState
  int food = -1; // Initialize with an invalid value, will be set in initState
  String direction = 'down';
  bool isPlaying = false;
  int score = 0;
  Timer? timer;

  // Game speeds based on difficulty
  Map<String, Duration> speeds = {
    'easy': Duration(milliseconds: 400),
    'medium': Duration(milliseconds: 250),
    'hard': Duration(milliseconds: 150),
  };

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for intro slide
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

    // Snake head bobbing animation
    _snakeHeadAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);

    // Apple bouncing animation
    _appleAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..repeat(reverse: true);

    // Background subtle color change animation
    _backgroundAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    )..repeat(reverse: true);

    _backgroundColorAnimation = ColorTween(
      begin: Colors.lightGreen[200],
      end: Colors.lightGreen[300],
    ).animate(_backgroundAnimController);

    // Initialize snake in the middle of the grid
    _initializeSnake();

    // Start the animation
    _animationController.forward();

    // Initialize food position to be different from snake
    _placeFood();
  }

  // Initialize snake in the middle of the grid
  void _initializeSnake() {
    // Calculate the middle of the grid
    int middleRow = squaresPerCol ~/ 2;
    int middleCol = squaresPerRow ~/ 2;

    // Convert to grid index (center position)
    int centerIndex = middleRow * squaresPerRow + middleCol;

    // Create a snake with 5 segments, starting from the center
    // and extending upwards (to avoid hitting bottom boundary too quickly)
    snake = [
      centerIndex,
      centerIndex - squaresPerRow, // one square up
      centerIndex - squaresPerRow * 2, // two squares up
    ];

    // Start moving downward
    direction = 'down';
  }

  // Place food in a random position that is not on the snake
  void _placeFood() {
    do {
      food = Random().nextInt(squaresPerRow * squaresPerCol);
    } while (snake.contains(food));
  }

  @override
  void dispose() {
    timer?.cancel();
    _animationController.dispose();
    _snakeHeadAnimController.dispose();
    _appleAnimController.dispose();
    _backgroundAnimController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  void toggleSound() {
    setState(() {
      isMuted = !isMuted;
    });
    playSound(isMuted ? 'x.mp3' : 'x.mp3');
  }

  Future<void> playSound(String soundName) async {
    if (!isMuted) {
      await audioPlayer.play(AssetSource('sfx/$soundName'));
    }
  }

  // Hide the mode selection and start the game
  void startGame() {
    setState(() {
      showModeSelection = false;
      isPlaying = true;
      // Reset snake to initial position
      _initializeSnake();
      score = 0;
      // Make sure food is not in the snake's path
      _placeFood();
    });
    playSound('equal.wav');
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(speeds[difficulty]!, (timer) {
      updateSnake();
    });
  }

  void updateSnake() {
    if (!isPlaying) return;

    setState(() {
      // Calculate the new head position
      int newHead;

      switch (direction) {
        case 'down':
          newHead = snake.first + squaresPerRow;
          // Check if hitting bottom wall
          if (newHead >= squaresPerRow * squaresPerCol) {
            gameOver();
            return;
          }
          break;
        case 'up':
          newHead = snake.first - squaresPerRow;
          // Check if hitting top wall
          if (newHead < 0) {
            gameOver();
            return;
          }
          break;
        case 'left':
          // Check if hitting left wall
          if (snake.first % squaresPerRow == 0) {
            gameOver();
            return;
          }
          newHead = snake.first - 1;
          break;
        case 'right':
          // Check if hitting right wall
          if ((snake.first + 1) % squaresPerRow == 0) {
            gameOver();
            return;
          }
          newHead = snake.first + 1;
          break;
        default:
          newHead = snake.first + squaresPerRow; // Default to down
      }

      // Extra boundary check to ensure we're within grid
      if (newHead < 0 || newHead >= squaresPerRow * squaresPerCol) {
        gameOver();
        return;
      }

      // Check if snake hits itself
      if (snake.contains(newHead)) {
        gameOver();
        return;
      }

      // Add new head
      snake.insert(0, newHead);

      // Check if snake eats food
      if (newHead == food) {
        // Generate new food position
        _placeFood();

        // Increase score
        score += 10;
        playSound('o.mp3');
      } else {
        // Remove the tail if no food was eaten
        snake.removeLast();
      }
    });
  }

  void gameOver() {
    timer?.cancel();
    isPlaying = false;
    playSound('reset.mp3');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Game Over!',
              style: TextStyle(
                fontFamily: 'BricolageGrotesque',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Score: $score',
                  style: TextStyle(
                    fontFamily: 'BricolageGrotesque',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(20),

                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    startGame();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    'Play Again',
                    style: TextStyle(
                      fontFamily: 'BricolageGrotesque',
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      showModeSelection = true;
                    });
                    _animationController.reset();
                    _animationController.forward();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      fontFamily: 'BricolageGrotesque',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void changeDirection(String newDirection) {
    // Prevent 180-degree turns
    if (direction == 'up' && newDirection == 'down') return;
    if (direction == 'down' && newDirection == 'up') return;
    if (direction == 'left' && newDirection == 'right') return;
    if (direction == 'right' && newDirection == 'left') return;

    setState(() {
      direction = newDirection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: AnimatedBuilder(
          animation: _backgroundColorAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(),
              child: SafeArea(
                child: Column(
                  children: [
                    CommonHeader(pageTitle: 'Jeu du Serpent'),
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
                            if (!showModeSelection)
                              Text(
                                'Score: $score',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'BricolageGrotesque',
                                  color: AppColors.accent,
                                ),
                              )
                            else
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
                            valueColor: AlwaysStoppedAnimation(
                              AppColors.accent,
                            ),
                            minHeight: 16,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                    // Header with sound control
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: IconButton(
                              icon: Icon(
                                isMuted ? Icons.volume_off : Icons.volume_up,
                                size: 24,
                                color: Colors.white,
                              ),
                              onPressed: toggleSound,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Game board
                    Expanded(
                      child: Center(
                        child: AspectRatio(
                          // Using a square aspect ratio for the game board
                          aspectRatio: 1.1,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              border: Border.all(
                                color: AppColors.accent,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: squaresPerRow,
                                  ),
                              itemCount: squaresPerRow * squaresPerCol,
                              itemBuilder: (context, index) {
                                if (snake.first == index) {
                                  // Snake head
                                  return Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                } else if (snake.contains(index)) {
                                  // Snake body
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  );
                                } else if (food == index) {
                                  // Food (apple)
                                  return Center(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: FittedBox(
                                        child: Image.asset(
                                          'assets/images/tictactoe/apple.png',
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  // Empty space
                                  return Container(
                                    margin: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Control buttons
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Up button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ControlButton(
                                icon: Icons.arrow_upward,
                                onPressed: () => changeDirection('up'),
                              ),
                            ],
                          ),
                          // Left, right buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ControlButton(
                                icon: Icons.arrow_back,
                                onPressed: () => changeDirection('left'),
                              ),
                              Gap(70),
                              ControlButton(
                                icon: Icons.arrow_forward,
                                onPressed: () => changeDirection('right'),
                              ),
                            ],
                          ),
                          // Down button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ControlButton(
                                icon: Icons.arrow_downward,
                                onPressed: () => changeDirection('down'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      // Mode selection popup at the bottom
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          showModeSelection
              ? SlideTransition(
                position: _slideAnimation,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
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
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  difficulty = 'easy';
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
                                      difficulty == 'easy'
                                          ? Colors.white
                                          : AppColors.purple,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    'Facile',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'BricolageGrotesque',
                                      color:
                                          difficulty == 'easy'
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
                                  difficulty = 'medium';
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
                                      difficulty == 'medium'
                                          ? Colors.white
                                          : AppColors.purple,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    'Moyen',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'BricolageGrotesque',
                                      color:
                                          difficulty == 'medium'
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
                                  difficulty = 'hard';
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
                                      difficulty == 'hard'
                                          ? Colors.white
                                          : AppColors.purple,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    'Difficile',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'BricolageGrotesque',
                                      color:
                                          difficulty == 'hard'
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

                      Text(
                        'Jeu du Serpent',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'BricolageGrotesque',
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Bienvenue dans le jeu du Serpent ! Dirigez votre serpent pour manger des pommes et grandir. Attention à ne pas heurter les murs ou votre propre queue ! Plus le niveau est difficile, plus le serpent se déplace rapidement. Bonne chance !',
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
              )
              : null,
    );
  }
}

class ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const ControlButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }
}
