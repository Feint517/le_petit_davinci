import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/features/lessons3/models/activity_model.dart';

final exampleLesson = Lesson(
  lessonId: 'alphabet_101',
  title: 'Learning the Alphabet',
  introduction: 'Let\'s learn the first three letters of the alphabet!',
  activities: [
    // VideoActivity(videoId: 'ccEpTTZW34g'),
    // DrawingActivity(
    //   prompt: 'Great job! Now, try to draw the letter "A"!',
    //   templateImagePath: ImageAssets.drawableA,
    // ),
    AudioMatchingActivity(
      prompt: 'Match the sound to the word!',
      pairs: [
        AudioWordPair(audioAssetPath: AudioAssets.a_en, word: 'A'),
        AudioWordPair(audioAssetPath: AudioAssets.b_en, word: 'B'),
        AudioWordPair(audioAssetPath: AudioAssets.c_en, word: 'C'),
      ],
    ),
    DrawingActivity(
      prompt: 'Awesome! Now let\'s draw the letter "B"!',
      templateImagePath: ImageAssets.drawableB,
    ),
  ],
);
