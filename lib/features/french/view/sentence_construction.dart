import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button_main.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/app_bar.dart';

class FrenchSentenceConstruction extends StatefulWidget {
  const FrenchSentenceConstruction({super.key});

  @override
  State<FrenchSentenceConstruction> createState() =>
      _FrenchSentenceConstructionState();
}

class _FrenchSentenceConstructionState
    extends State<FrenchSentenceConstruction> {
  // Inject the controller
  // Get.put() initializes the controller if it hasn't been already.lllhhh
  // Using Get.find() if you know it's already been initialized elsewhere (e.g., GetX bi
  // Define the initial set of words to be dragged
  final List<String> _initialDraggableWords = [
    'lire',
    "J'aime",
    'livres',
    'des',
  ];
  // Define the correct order of words for the sentence
  final List<String> _correctSentence = ["J'aime", 'lire', 'des', 'livres'];

  // State to manage the words currently available for dragging
  late List<String> _draggableWords;
  // State to manage the words dropped into the input fields
  late List<String> _droppedWords;
  // State to manage the feedback message
  String _feedbackMessage = '';
  // State to manage the feedback type (success or error)
  bool? _isCorrectAnswer; // null: no check yet, true: correct, false: incorrect

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  // Initializes or resets the game state
  void _initializeGame() {
    setState(() {
      // Shuffle the initial words to provide a different arrangement each time
      _draggableWords = List.from(_initialDraggableWords)..shuffle();
      // Initialize dropped words with empty strings, one for each word in the correct sentence
      _droppedWords = List.generate(_correctSentence.length, (index) => '');
      _feedbackMessage = '';
      _isCorrectAnswer = null;
    });
  }

  // Checks if the current arrangement of dropped words is correct
  void _checkAnswer() {
    // First, check if all slots are filled
    if (_droppedWords.contains('')) {
      setState(() {
        _feedbackMessage = 'Please fill all the blanks!';
        _isCorrectAnswer = false; // Treat as incorrect for feedback styling
      });
      return;
    }

    // Compare the dropped words with the correct sentence
    bool isCorrect = true;
    for (int i = 0; i < _correctSentence.length; i++) {
      if (_droppedWords[i] != _correctSentence[i]) {
        isCorrect = false;
        break;
      }
    }

    setState(() {
      _isCorrectAnswer = isCorrect;
      if (isCorrect) {
        _feedbackMessage = 'Correct! Well done!';
      } else {
        _feedbackMessage = 'Try again! That\'s not quite right.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          spacing: 10,
          children: [
            const CustomNavBar(
              chipText: 'Français',
              chipColor: AppColors.bluePrimaryDark,
            ),

            Text(
              'Phrase à reconstruire',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Exercer la syntaxe et l'ordre des mots.",
              style: TextStyle(color: AppColors.textSecondary),
            ),

            Stack(
              alignment: Alignment.centerLeft, // Align children to the left
              children: [
                // The main text container
                SvgPicture.asset(
                  SvgAssets.architecteDesPhrases,
                  fit: BoxFit.cover,
                  width: context.width / 2.5,
                ),
              ],
            ),
            Flexible(
              child: Stack(
                children: [
                  SvgPicture.asset(
                    SvgAssets.primaryBlueTopRoundBg,
                    fit: BoxFit.fill,
                    height: context.height,
                    alignment: Alignment.bottomCenter,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 20,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Glisser ces mots:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                          Wrap(
                            spacing: 10.0, // horizontal space between items
                            runSpacing: 10.0, // vertical space between lines
                            alignment: WrapAlignment.center,
                            children:
                                _draggableWords.map((word) {
                                  return Padding(
                                    padding: const EdgeInsets.all(
                                      4.0,
                                    ), // Smaller padding for each word
                                    child: Draggable<String>(
                                      data: word, // The data being dragged
                                      feedback: Material(
                                        // What the user sees while dragging
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: AppColors.bluePrimaryDark,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 6,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            word,
                                            style: const TextStyle(
                                              color: AppColors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      childWhenDragging: Container(
                                        // What stays in place of the dragged child (can be empty)
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color:
                                              Colors
                                                  .grey[700], // Slightly darker to show it's gone
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          word,
                                          style: TextStyle(
                                            color: AppColors.white.withOpacity(
                                              0.4,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        // The actual draggable widget
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: AppColors.bluePrimaryDark,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 4,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          word,
                                          style: const TextStyle(
                                            color: AppColors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(_droppedWords.length, (
                              index,
                            ) {
                              return SizedBox(
                                width: 80, // Fixed width for input fields
                                child: DragTarget<String>(
                                  onWillAccept:
                                      (data) => true, // Always allow dropping
                                  onAccept: (data) {
                                    setState(() {
                                      // If the slot is already filled, add the word back to draggable
                                      if (_droppedWords[index].isNotEmpty) {
                                        _draggableWords.add(
                                          _droppedWords[index],
                                        );
                                      }
                                      _droppedWords[index] =
                                          data; // Place the dropped word
                                      _draggableWords.remove(
                                        data,
                                      ); // Remove from draggable list
                                      _feedbackMessage =
                                          ''; // Clear feedback on new drop
                                      _isCorrectAnswer = null;
                                    });
                                  },
                                  builder: (
                                    context,
                                    candidateData,
                                    rejectedData,
                                  ) {
                                    return TextField(
                                      controller: TextEditingController(
                                        text: _droppedWords[index],
                                      ),
                                      textAlign: TextAlign.center,
                                      enabled:
                                          false, // Make it non-editable by keyboard
                                      style: const TextStyle(
                                        color: AppColors.white,
                                        fontSize: 16,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),

                                        hintText: '', // Placeholder text
                                        hintStyle: TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                          ),
                          // Action Buttons
                          CustomButtonNew(
                            buttonColor: AppColors.secondary,
                            shadowColor: AppColors.orangeAccentDark,
                            label: 'Vérifier ma réponse',
                            labelColor: AppColors.background,
                            onPressed: _checkAnswer,
                            icon: Icons.arrow_outward_rounded,
                            iconColor: AppColors.backgroundLight,
                            width: context.width / 1.5,
                          ),
                          CustomButtonNew(
                            buttonColor: AppColors.orange,
                            shadowColor: AppColors.pinkMedium,
                            label: 'Reset',
                            labelColor: AppColors.background,
                            onPressed: _initializeGame,
                            icon: Icons.refresh_rounded,
                            iconColor: AppColors.backgroundLight,
                            width: context.width / 1.5,
                          ),

                          const SizedBox(
                            height: 20,
                          ), // Space before feedback message
                          // Feedback Message
                          if (_feedbackMessage.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    _isCorrectAnswer == true
                                        ? Colors.green.shade700
                                        : Colors.red.shade700,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                _feedbackMessage,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
