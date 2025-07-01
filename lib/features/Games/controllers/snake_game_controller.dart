import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnakeController extends GetxController with GetTickerProviderStateMixin {
  //* Constants
  static const int squaresPerRow = 20;
  static const int squaresPerCol = 18;

  //* Animation controller for the popup
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  //* Additional animations
  late AnimationController snakeHeadAnimController;
  late AnimationController appleAnimController;
  late AnimationController backgroundAnimController;
  late Animation<Color?> backgroundColorAnimation;

  //* Audio
  final audioPlayer = AudioPlayer();
  final isMuted = false.obs;

  //* Game config
  final showModeSelection = true.obs;
  final difficulty = 'medium'.obs;

  //* Game state
  final snake = <int>[].obs;
  final food = (-1).obs; // Initialize with an invalid value
  final direction = 'down'.obs;
  final isPlaying = false.obs;
  final score = 0.obs;
  Timer? timer;

  //* Game speeds based on difficulty
  Map<String, Duration> speeds = {
    'easy': const Duration(milliseconds: 400),
    'medium': const Duration(milliseconds: 250),
    'hard': const Duration(milliseconds: 150),
  };

  @override
  void onInit() {
    super.onInit();

    //* Initialize animation controller for intro slide
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

    //* Snake head bobbing animation
    snakeHeadAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    //* Apple bouncing animation
    appleAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    //* Background subtle color change animation
    backgroundAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..repeat(reverse: true);

    backgroundColorAnimation = ColorTween(
      begin: Colors.lightGreen[200],
      end: Colors.lightGreen[300],
    ).animate(backgroundAnimController);

    //* Initialize snake in the middle of the grid
    _initializeSnake();

    //* Start the animation
    animationController.forward();

    //* Initialize food position to be different from snake
    _placeFood();
  }

  //* Initialize snake in the middle of the grid
  void _initializeSnake() {
    //* Calculate the middle of the grid
    int middleRow = squaresPerCol ~/ 2;
    int middleCol = squaresPerRow ~/ 2;

    //* Convert to grid index (center position)
    int centerIndex = middleRow * squaresPerRow + middleCol;

    //* Create a snake with 3 segments, starting from the center
    //* and extending upwards (to avoid hitting bottom boundary too quickly)
    snake.value = [
      centerIndex,
      centerIndex - squaresPerRow, //? one square up
      centerIndex - squaresPerRow * 2, //? two squares up
    ];

    //* Start moving downward
    direction.value = 'down';
  }

  //* Place food in a random position that is not on the snake
  void _placeFood() {
    int newFood;
    do {
      newFood = Random().nextInt(squaresPerRow * squaresPerCol);
    } while (snake.contains(newFood));

    food.value = newFood;
  }

  void toggleSound() {
    isMuted.value = !isMuted.value;
    playSound(isMuted.value ? 'x.mp3' : 'x.mp3');
  }

  Future<void> playSound(String soundName) async {
    if (!isMuted.value) {
      await audioPlayer.play(AssetSource('sfx/$soundName'));
    }
  }

  //* Hide the mode selection and start the game
  void startGame() {
    showModeSelection.value = false;
    isPlaying.value = true;

    //* Reset snake to initial position
    _initializeSnake();
    score.value = 0;

    //* Make sure food is not in the snake's path
    _placeFood();

    playSound('equal.wav');
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(speeds[difficulty.value]!, (timer) {
      updateSnake();
    });
  }

  void updateSnake() {
    if (!isPlaying.value) return;

    //* Calculate the new head position
    int newHead;

    switch (direction.value) {
      case 'down':
        newHead = snake.first + squaresPerRow;
        //* Check if hitting bottom wall
        if (newHead >= squaresPerRow * squaresPerCol) {
          gameOver();
          return;
        }
        break;
      case 'up':
        newHead = snake.first - squaresPerRow;
        //* Check if hitting top wall
        if (newHead < 0) {
          gameOver();
          return;
        }
        break;
      case 'left':
        //* Check if hitting left wall
        if (snake.first % squaresPerRow == 0) {
          gameOver();
          return;
        }
        newHead = snake.first - 1;
        break;
      case 'right':
        //* Check if hitting right wall
        if ((snake.first + 1) % squaresPerRow == 0) {
          gameOver();
          return;
        }
        newHead = snake.first + 1;
        break;
      default:
        newHead = snake.first + squaresPerRow; //? Default to down
    }

    //* Extra boundary check to ensure we're within grid
    if (newHead < 0 || newHead >= squaresPerRow * squaresPerCol) {
      gameOver();
      return;
    }

    //* Check if snake hits itself
    if (snake.contains(newHead)) {
      gameOver();
      return;
    }

    //* Create a new list to trigger reactivity
    List<int> newSnake = List.from(snake);

    //* Add new head
    newSnake.insert(0, newHead);

    //* Check if snake eats food
    if (newHead == food.value) {
      //* Generate new food position
      _placeFood();

      //* Increase score
      score.value += 10;
      playSound('o.mp3');
    } else {
      //* Remove the tail if no food was eaten
      newSnake.removeLast();
    }

    //* Update the snake list
    snake.value = newSnake;
  }

  void gameOver() {
    timer?.cancel();
    isPlaying.value = false;
    playSound('reset.mp3');

    //* The dialog will be shown from the view
  }

  void changeDirection(String newDirection) {
    //* Prevent 180-degree turns
    if (direction.value == 'up' && newDirection == 'down') return;
    if (direction.value == 'down' && newDirection == 'up') return;
    if (direction.value == 'left' && newDirection == 'right') return;
    if (direction.value == 'right' && newDirection == 'left') return;

    direction.value = newDirection;
  }

  void setDifficulty(String newDifficulty) {
    difficulty.value = newDifficulty;
    playSound('o.mp3');
  }

  void returnToMenu() {
    showModeSelection.value = true;
    animationController.reset();
    animationController.forward();
  }

  @override
  void onClose() {
    timer?.cancel();
    animationController.dispose();
    snakeHeadAnimController.dispose();
    appleAnimController.dispose();
    backgroundAnimController.dispose();
    audioPlayer.dispose();
    super.onClose();
  }
}
