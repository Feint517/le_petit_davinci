import 'package:le_petit_davinci/features/lessons2/models/lesson_model.dart';

class DrawLettersActivity extends LessonActivity {
  final List<LetterModel> letters;
  final String pronunciationAudioPath;

  const DrawLettersActivity({
    required super.id,
    required super.title,
    required super.instruction,
    required this.letters,
    this.pronunciationAudioPath = '',
  }) : super(type: ActivityType.drawLetters);
}

class LetterModel {
  final String letter;
  final String templatePath;
  final String pronunciation;

  const LetterModel({
    required this.letter,
    required this.templatePath,
    this.pronunciation = '',
  });
}
