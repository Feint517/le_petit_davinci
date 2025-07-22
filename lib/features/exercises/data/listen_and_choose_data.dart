import 'package:le_petit_davinci/features/exercises/models/listen_and_choose_exercise_model.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';

final listenAndChooseLevels = {
  3: [
    // Level 3
    ListenAndChooseExercise(
      audioAsset: AudioAssets.cat,
      imageAssets: [
        ImageAssets.banana,
        ImageAssets.dog,
        ImageAssets.apple,
        ImageAssets.cat,
      ],
      correctIndex: 3,
      label: 'Cat',
    ),
    ListenAndChooseExercise(
      audioAsset: AudioAssets.dog,
      imageAssets: [
        ImageAssets.cat,
        ImageAssets.dog,
        ImageAssets.banana,
        ImageAssets.apple,
      ],
      correctIndex: 1,
      label: 'Dog',
    ),
    // Add more exercises for this level...
  ],
  // Add more levels as needed
};
