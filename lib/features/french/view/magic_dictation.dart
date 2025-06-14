import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button_main.dart';

import 'package:le_petit_davinci/core/widgets/top_navigation.dart';
import 'package:le_petit_davinci/features/french/view/lessons.dart';

class FrenchMagicDictation extends StatefulWidget {
  const FrenchMagicDictation({super.key});

  @override
  State<FrenchMagicDictation> createState() => _FrenchMagicDictationState();
}

class _FrenchMagicDictationState extends State<FrenchMagicDictation> {
  final FlutterTts _tts = FlutterTts();
  final TextEditingController _answerController = TextEditingController();
  int _currentWordIndex = 0;
  int _correctAnswers = 0;
  bool _showValidation = false;
  bool _isCorrect = false;
  bool _isPlaying = false;

  final List<DictationWord> _words = [
    DictationWord(word: "bonjour", hint: "Salutation du matin"),
    DictationWord(
      word: "merci",
      hint: "Ce qu'on dit quand on reçoit quelque chose",
    ),
    DictationWord(word: "école", hint: "Lieu où les enfants apprennent"),
    DictationWord(word: "soleil", hint: "Il brille dans le ciel"),
    DictationWord(word: "ordinateur", hint: "Machine pour travailler ou jouer"),
  ];

  @override
  void initState() {
    super.initState();
    _initTts();
    _speakCurrentWord();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage("fr-FR");
    await _tts.setSpeechRate(0.5);
    _tts.setStartHandler(() => setState(() => _isPlaying = true));
    _tts.setCompletionHandler(() => setState(() => _isPlaying = false));
  }

  Future<void> _speakCurrentWord() async {
    await _tts.speak(_words[_currentWordIndex].word);
  }

  void _checkAnswer() {
    final userAnswer = _answerController.text.trim().toLowerCase();
    final correctAnswer = _words[_currentWordIndex].word.toLowerCase();

    setState(() {
      _showValidation = true;
      _isCorrect = userAnswer == correctAnswer;

      if (_isCorrect) {
        _correctAnswers++;
      }
    });
  }

  void _nextWord() {
    setState(() {
      _currentWordIndex++;
      _answerController.clear();
      _showValidation = false;

      if (_currentWordIndex < _words.length) {
        _speakCurrentWord();
      } else {
        // Exercise completed
        Get.to(
          () => const FrenchLessons(),
          duration: const Duration(milliseconds: 500),
          transition: Transition.rightToLeft,
        );
      }
    });
  }

  @override
  void dispose() {
    _tts.stop();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLastWord = _currentWordIndex == _words.length - 1;
    final currentWord =
        _currentWordIndex < _words.length
            ? _words[_currentWordIndex]
            : _words.last;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            TopNavigation(
              text: 'Français',
              buttonColor: AppColors.bluePrimaryDark,
            ),

            Text(
              'Dictée magique',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "Travailler l'écoute et l'orthographe de mots simples.",
              style: TextStyle(color: AppColors.textSecondary),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  SvgPicture.asset(
                    SvgAssets.maitriseDesSons,
                    fit: BoxFit.cover,
                    width: context.width / 2.5,
                  ),
                ],
              ),
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
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 20,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '$_correctAnswers mots réussis sur ${_words.length}',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            'Mot ${_currentWordIndex + 1}/${_words.length}',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),

                          Text(
                            currentWord.hint,
                            style: TextStyle(
                              color: AppColors.white.withOpacity(0.8),
                              fontStyle: FontStyle.italic,
                            ),
                          ),

                          GestureDetector(
                            onTap: _speakCurrentWord,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    _isPlaying
                                        ? AppColors.bluePrimary
                                        : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                SvgAssets.speaker,
                                width: context.width / 5,
                              ),
                            ),
                          ),

                          SizedBox(
                            width: context.width / 1.5,
                            child: TextField(
                              controller: _answerController,
                              style: TextStyle(color: AppColors.white),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.white,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.white,
                                  ),
                                ),
                                hintText: 'Écrivez votre réponse',
                                hintStyle: TextStyle(
                                  color: AppColors.white.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),

                          if (_showValidation) ...[
                            Text(
                              _isCorrect ? 'Correct!' : 'Incorrect',
                              style: TextStyle(
                                color:
                                    _isCorrect
                                        ? AppColors.accent
                                        : AppColors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            if (!_isCorrect)
                              Text(
                                'La réponse correcte: ${currentWord.word}',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ],

                          CustomButtonNew(
                            buttonColor:
                                _showValidation
                                    ? (_isCorrect
                                        ? AppColors.accent
                                        : AppColors.orange)
                                    : AppColors.secondary,
                            shadowColor:
                                _showValidation
                                    ? (_isCorrect
                                        ? AppColors.accent2
                                        : AppColors.orangeAccentDark)
                                    : AppColors.orangeAccentDark,
                            label:
                                _showValidation
                                    ? (isLastWord && _isCorrect
                                        ? 'Terminer'
                                        : 'Continuer')
                                    : 'Vérifier ma réponse',
                            labelColor: AppColors.background,
                            onPressed:
                                _showValidation ? _nextWord : _checkAnswer,
                            icon:
                                _showValidation
                                    ? Icons.arrow_forward_rounded
                                    : Icons.check_rounded,
                            iconColor: AppColors.backgroundLight,
                            width: context.width / 1.5,
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

class DictationWord {
  final String word;
  final String hint;

  DictationWord({required this.word, required this.hint});
}
