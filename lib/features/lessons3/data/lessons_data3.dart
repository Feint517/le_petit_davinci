import 'package:le_petit_davinci/features/lessons3/models/activity_model.dart';

final exampleLesson = Lesson(
    lessonId: 'alphabet_101',
    title: 'Learning the Alphabet',
    introduction: 'Let\'s learn the first three letters of the alphabet!',
    activities: [
      VideoActivity(videoId: 'ccEpTTZW34g'),
      DrawingActivity(prompt: 'Great job! Now, try to draw the letter "A"!'),
    ],
  );
