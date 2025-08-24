import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/data/models/subject/level_content.dart';
import 'package:le_petit_davinci/features/exercises/models/solve_equation_exercise_model.dart';
import 'package:le_petit_davinci/features/lessons/models/activity_model.dart';
import 'package:le_petit_davinci/features/lessons/models/audio_matching_activity_model.dart';
import 'package:le_petit_davinci/features/lessons/models/audio_pair_model.dart';
import 'package:le_petit_davinci/features/lessons/models/drawing_activity_model.dart';
import 'package:le_petit_davinci/features/lessons/models/video_activity_model.dart';

final Map<int, LevelContent> unifiedMathLevels = {
  // ========== Group 1: Numbers 1-10 ==========
  1: LessonSet(
    Lesson(
      lessonId: 'math_numbers_1_10',
      title: 'Les nombres de 1 à 10',
      introduction: 'Apprenons à reconnaître et compter les nombres de 1 à 10!',
      activities: [
        VideoActivity(videoId: 'EXAMPLE_VIDEO_ID'),
        DrawingActivity(
          prompt: 'Dessine le chiffre 1!',
          templateImagePath: ImageAssets.drawableA,
          //TODO: change it to a number drawable
        ),
        DrawingActivity(
          prompt: 'Maintenant dessine le chiffre 2!',
          templateImagePath: ImageAssets.drawableA,
          //TODO: change it to a number drawable
        ),
        AudioMatchingActivity(
          prompt: 'Associe le nombre à son nom!',
          pairs: [
            AudioWordPair(audioAssetPath: AudioAssets.number1_fr, word: '1'),
            AudioWordPair(audioAssetPath: AudioAssets.number2_fr, word: '2'),
            AudioWordPair(audioAssetPath: AudioAssets.number3_fr, word: '3'),
          ],
        ),
      ],
    ),
  ),

  2: ExerciseSet([
    SolveEquationExercise(
      equation: '1 + 2 = ?',
      options: [2, 3, 4, 5],
      correctAnswer: 3,
    ),
  ]),
};
