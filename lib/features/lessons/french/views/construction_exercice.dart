import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/data/french_words_suggestions.dart';
import 'package:le_petit_davinci/data/sentence_translation.dart';
import 'dart:async';

import 'package:le_petit_davinci/features/lessons/french/models/english_to_french.dart';
import 'package:le_petit_davinci/features/lessons/french/views/construction_introduction_lesson.dart';

class ConstructionExercice extends StatefulWidget {
  final int day;

  const ConstructionExercice({super.key, required this.day});

  @override
  State<ConstructionExercice> createState() => _ConstructionExerciceState();
}

class _ConstructionExerciceState extends State<ConstructionExercice> {
  late List<EnglishToFrench> _sentences;
  int _currentIndex = 0;
  bool _showResult = false;
  bool _isCorrect = false;
  int _score = 0;

  // For multiple choice options
  late List<String> _currentOptions = [];
  String? _selectedAnswer;

  // Timer related variables
  late Timer _timer;
  int _remainingSeconds = 15;
  bool _timerActive = false;

  @override
  void initState() {
    super.initState();
    _sentences = SentencesData.getSentencesByDay(widget.day);
    _generateOptions();
    _startTimer();
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  void _startTimer() {
    _remainingSeconds = 15;
    _timerActive = true;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          // Time's up - mark as incorrect
          _timer.cancel();
          _timerActive = false;
          _showResult = true;
          _isCorrect = false;
          // Auto-proceed to next question after a delay
          Future.delayed(Duration(seconds: 2), () {
            if (mounted) {
              _nextQuestion();
            }
          });
        }
      });
    });
  }

  void _cancelTimer() {
    if (_timerActive) {
      _timer.cancel();
      _timerActive = false;
    }
  }

  // Generate 6 options - 1 correct and 5 incorrect answers
  void _generateOptions() {
    _currentOptions = [];
    // Add the correct answer
    _currentOptions.add(_sentences[_currentIndex].frenchSentence);

    // Create a copy of the suggestions list to avoid duplicates
    final suggestions = List<String>.from(
      FrenchSentenceSuggestions.frenchSentenceSuggestions,
    );

    // Remove the correct answer from suggestions if it exists there
    suggestions.remove(_sentences[_currentIndex].frenchSentence);

    // Shuffle the suggestions and pick 5 random words
    suggestions.shuffle();
    for (int i = 0; i < 5 && i < suggestions.length; i++) {
      _currentOptions.add(suggestions[i]);
    }

    // Shuffle the options so the correct answer isn't always first
    _currentOptions.shuffle();

    // Reset selection state
    _selectedAnswer = null;
    _showResult = false;
  }

  void _checkAnswer() {
    if (_selectedAnswer == null) return;

    _cancelTimer();

    setState(() {
      _showResult = true;
      _isCorrect = _selectedAnswer == _sentences[_currentIndex].frenchSentence;

      if (_isCorrect) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    _cancelTimer();

    setState(() {
      if (_currentIndex < _sentences.length - 1) {
        _currentIndex++;
        _generateOptions();
        _showResult = false;
        _selectedAnswer = null;
        _startTimer();
      } else {
        // Show final score or navigate to results page
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Text('Exercise Complete!'),
            content: Text('Your score: $_score/${_sentences.length}'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.off(
                    () => ConstructionIntroductionLesson(),
                    transition: Transition.leftToRight,
                    duration: Duration(milliseconds: 500),
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jour ${widget.day} - Exercice'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Score: $_score/${_sentences.length}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //* Timer display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color:
                        _remainingSeconds > 3 ? AppColors.purple : Colors.red,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.timer, color: Colors.white),
                      const Gap(8),
                      Text(
                        '$_remainingSeconds',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(16),

            Text('Translate to French:', style: TextStyle(fontSize: 18)),
            Gap(20),
            Text(
              _sentences[_currentIndex].englishSentence,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Gap(30),

            // Multiple choice options
            Expanded(
              child: ListView.builder(
                itemCount: _currentOptions.length,
                itemBuilder: (context, index) {
                  final option = _currentOptions[index];
                  final isCorrectOption =
                      option == _sentences[_currentIndex].frenchSentence;
                  final isSelected = option == _selectedAnswer;

                  // Determine color based on selection and correctness
                  Color? cardColor;
                  if (_showResult) {
                    if (isCorrectOption) {
                      cardColor = Colors.green.shade100;
                    } else if (isSelected && !isCorrectOption) {
                      cardColor = Colors.red.shade100;
                    }
                  } else if (isSelected) {
                    cardColor = AppColors.purple;
                  }

                  return Card(
                    color: cardColor,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: InkWell(
                      onTap:
                          _showResult
                              ? null
                              : () {
                                setState(() {
                                  _selectedAnswer = option;
                                });
                              },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                option,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ),
                            if (_showResult && isCorrectOption)
                              Icon(Icons.check_circle, color: Colors.green),
                            if (_showResult && isSelected && !isCorrectOption)
                              Icon(Icons.cancel, color: Colors.red),
                            if (!_showResult && isSelected)
                              Icon(
                                Icons.radio_button_checked,
                                color: Colors.blue,
                              ),
                            if (!_showResult && !isSelected)
                              Icon(
                                Icons.radio_button_unchecked,
                                color: Colors.grey,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                !_showResult
                    ? CustomButton(
                      variant: ButtonVariant.secondary,
                      size: ButtonSize.lg,
                      width: 200,
                      label: 'Verifier la Réponse',
                      onPressed: _selectedAnswer != null ? _checkAnswer : null,
                    )
                    : CustomButton(
                      variant: ButtonVariant.secondary,
                      size: ButtonSize.lg,
                      label:
                          _currentIndex < _sentences.length - 1
                              ? 'Question Suivante'
                              : 'Terminer',
                      onPressed: _nextQuestion,
                    ),
              ],
            ),
            const Gap(10),
            Text(
              'Question ${_currentIndex + 1} of ${_sentences.length}',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
