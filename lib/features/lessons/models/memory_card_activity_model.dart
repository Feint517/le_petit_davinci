// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';
// import 'package:le_petit_davinci/features/lessons/models/lesson_model.dart';
// import 'package:le_petit_davinci/features/lessons/models/memory_card_models.dart';
// import 'package:le_petit_davinci/features/lessons/views/memory_card_activity_view.dart';
// import 'package:le_petit_davinci/features/levels/models/activity_model.dart';

// class MemoryCardActivity extends Activity {
//   MemoryCardActivity({
//     required this.instruction,
//     required this.cardPairs,
//     this.difficulty = MemoryDifficulty.medium,
//     this.timeLimit, // Optional time limit in seconds
//   }) {
//     // Initialize mascot controller
//     mascotController = TalkingMascotController(
//       messages: [
//         'Let\'s play a memory game!',
//         instruction,
//         'Find the matching pairs!',
//       ],
//     );

//     // Listen to mascot completion
//     ever(mascotController.isCompleted, (bool isDone) {
//       if (isDone) {
//         Future.delayed(const Duration(milliseconds: 400), () {
//           isIntroCompleted.value = true;
//         });
//       }
//     });

//     // Initialize game state
//     _initializeGame();
//   }

//   final String instruction;
//   final List<CardPair> cardPairs;
//   final MemoryDifficulty difficulty;
//   final int? timeLimit; // Optional time limit

//   /// State management - following the same pattern as FillTheBlankExercise
//   late final TalkingMascotController mascotController;
//   final RxnBool isIntroCompleted = RxnBool(false);
//   final Rxn<MemoryGameState> gameState = Rxn<MemoryGameState>(
//     MemoryGameState(
//       allCards: [],
//       flippedCards: [],
//       matchedPairs: [],
//       moves: 0,
//       timeElapsed: 0,
//       isGameComplete: false,
//     ),
//   );

//   Timer? _gameTimer;
//   final RxnBool isGameStarted = RxnBool(false);

//   /// Initialize the game with shuffled cards
//   void _initializeGame() {
//     final allCards = <MemoryCard>[];

//     // Add all cards from pairs
//     for (final pair in cardPairs) {
//       allCards.add(pair.card1);
//       allCards.add(pair.card2);
//     }

//     // Shuffle the cards
//     allCards.shuffle();

//     gameState.value =
//         gameState.value?.copyWith(
//           allCards: allCards,
//           flippedCards: [],
//           matchedPairs: [],
//           moves: 0,
//           timeElapsed: 0,
//           isGameComplete: false,
//         ) ??
//         MemoryGameState(
//           allCards: allCards,
//           flippedCards: [],
//           matchedPairs: [],
//           moves: 0,
//           timeElapsed: 0,
//           isGameComplete: false,
//         );
//   }

//   /// Start the game timer
//   void startGame() {
//     isGameStarted.value = true;
//     if (timeLimit != null) {
//       _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//         final currentState = gameState.value;
//         if (currentState != null) {
//           final newTime = currentState.timeElapsed + 1;
//           gameState.value = currentState.copyWith(timeElapsed: newTime);

//           if (newTime >= timeLimit!) {
//             _endGame(false); // Time's up
//           }
//         }
//       });
//     }
//   }

//   /// Handle card flip
//   void flipCard(MemoryCard card) {
//     if (isGameStarted.value != true) {
//       startGame();
//     }

//     final currentState = gameState.value;
//     if (currentState == null) return;

//     // Don't allow flipping if card is already flipped or matched
//     if (currentState.flippedCards.contains(card) || _isCardMatched(card)) {
//       return;
//     }

//     // Don't allow flipping more than 2 cards at once
//     if (currentState.flippedCards.length >= 2) {
//       return;
//     }

//     final newFlippedCards = List<MemoryCard>.from(currentState.flippedCards);
//     newFlippedCards.add(card);

//     gameState.value = currentState.copyWith(flippedCards: newFlippedCards);

//     // Check for match if 2 cards are flipped
//     if (newFlippedCards.length == 2) {
//       _checkForMatch(newFlippedCards);
//     }
//   }

//   /// Check if two flipped cards match
//   void _checkForMatch(List<MemoryCard> flippedCards) {
//     final card1 = flippedCards[0];
//     final card2 = flippedCards[1];

//     // Find the pair that contains these cards
//     CardPair? matchingPair;
//     for (final pair in cardPairs) {
//       if ((pair.card1.id == card1.id && pair.card2.id == card2.id) ||
//           (pair.card1.id == card2.id && pair.card2.id == card1.id)) {
//         matchingPair = pair;
//         break;
//       }
//     }

//     final currentState = gameState.value;
//     if (currentState == null) return;

//     final newMoves = currentState.moves + 1;

//     if (matchingPair != null) {
//       // Match found!
//       final newMatchedPairs = List<CardPair>.from(currentState.matchedPairs);
//       newMatchedPairs.add(matchingPair);

//       gameState.value = currentState.copyWith(
//         matchedPairs: newMatchedPairs,
//         flippedCards: [],
//         moves: newMoves,
//       );

//       // Check if game is complete
//       if (newMatchedPairs.length == cardPairs.length) {
//         _endGame(true);
//       }
//     } else {
//       // No match - flip cards back after a delay
//       Future.delayed(const Duration(milliseconds: 1000), () {
//         final delayedState = gameState.value;
//         if (delayedState != null) {
//           gameState.value = delayedState.copyWith(
//             flippedCards: [],
//             moves: newMoves,
//           );
//         }
//       });
//     }
//   }

//   /// Check if a card is already matched
//   bool _isCardMatched(MemoryCard card) {
//     final currentState = gameState.value;
//     if (currentState == null) return false;

//     for (final pair in currentState.matchedPairs) {
//       if (pair.card1.id == card.id || pair.card2.id == card.id) {
//         return true;
//       }
//     }
//     return false;
//   }

//   /// End the game
//   void _endGame(bool won) {
//     _gameTimer?.cancel();
//     isCompleted.value = true;
//   }

//   /// Reset the game
//   void resetGame() {
//     _gameTimer?.cancel();
//     isGameStarted.value = false;
//     _initializeGame();
//   }

//   /// Get score based on moves and time
//   int getScore() {
//     final state = gameState.value;
//     if (state == null) return 0;

//     final baseScore = cardPairs.length * 100;
//     final movePenalty = state.moves * 5;
//     final timeBonus =
//         timeLimit != null ? (timeLimit! - state.timeElapsed) * 2 : 0;

//     return (baseScore - movePenalty + timeBonus).clamp(0, baseScore);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MemoryCardActivityView(activity: this);
//   }

//   /// Following the same pattern as FillTheBlankExercise
//   bool get isAnswerReady => gameState.value?.isGameComplete ?? false;

//   Stream<bool> get isAnswerReadyStream =>
//       gameState.stream.map((state) => state?.isGameComplete ?? false);

//   /// The view will call this method when the user flips a card.
//   void selectCard(MemoryCard card) {
//     flipCard(card);
//   }

//   /// Reset the activity state
//   void reset() {
//     _resetActivityState();
//   }

//   @override
//   void dispose() {
//     _gameTimer?.cancel();
//     mascotController.dispose();
//     // Reset the activity state when disposing (when user moves to next screen)
//     _resetActivityState();
//     super.dispose();
//   }

//   /// Reset the activity state to initial values
//   void _resetActivityState() {
//     isIntroCompleted.value = false;
//     isGameStarted.value = false;
//     isCompleted.value = false;
//     _initializeGame();
//   }
// }
