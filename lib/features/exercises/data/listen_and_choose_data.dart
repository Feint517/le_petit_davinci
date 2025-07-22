import 'package:le_petit_davinci/features/exercises/models/listen_and_choose_exercise_model.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';

final listenAndChooseEnglishLevels = {
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
    // More exercises
    ListenAndChooseExercise(
      audioAsset: AudioAssets.parrot,
      imageAssets: [
        ImageAssets.parrot,
        ImageAssets.cat,
        ImageAssets.dog,
        ImageAssets.apple,
      ],
      correctIndex: 0,
      label: 'Parrot',
    ),
    ListenAndChooseExercise(
      audioAsset: AudioAssets.apple,
      imageAssets: [
        ImageAssets.banana,
        ImageAssets.apple,
        ImageAssets.cat,
        ImageAssets.dog,
      ],
      correctIndex: 1,
      label: 'Apple',
    ),
    ListenAndChooseExercise(
      audioAsset: AudioAssets.banana,
      imageAssets: [
        ImageAssets.apple,
        ImageAssets.banana,
        ImageAssets.cat,
        ImageAssets.dog,
      ],
      correctIndex: 1,
      label: 'Banana',
    ),
    ListenAndChooseExercise(
      audioAsset: AudioAssets.lion,
      imageAssets: [
        ImageAssets.lion,
        ImageAssets.tiger,
        ImageAssets.elephant,
        ImageAssets.bear,
      ],
      correctIndex: 0,
      label: 'Lion',
    ),
    ListenAndChooseExercise(
      audioAsset: AudioAssets.tiger,
      imageAssets: [
        ImageAssets.lion,
        ImageAssets.tiger,
        ImageAssets.elephant,
        ImageAssets.bear,
      ],
      correctIndex: 1,
      label: 'Tiger',
    ),
    ListenAndChooseExercise(
      audioAsset: AudioAssets.elephant,
      imageAssets: [
        ImageAssets.lion,
        ImageAssets.tiger,
        ImageAssets.elephant,
        ImageAssets.bear,
      ],
      correctIndex: 2,
      label: 'Elephant',
    ),
    ListenAndChooseExercise(
      audioAsset: AudioAssets.bear,
      imageAssets: [
        ImageAssets.lion,
        ImageAssets.tiger,
        ImageAssets.elephant,
        ImageAssets.bear,
      ],
      correctIndex: 3,
      label: 'Bear',
    ),
  ],
  // Add more levels as needed
};
