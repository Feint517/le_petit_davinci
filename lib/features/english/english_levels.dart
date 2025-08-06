import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_model.dart';
import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_config_model.dart';
import 'package:le_petit_davinci/features/english/level_content.dart';
import 'package:le_petit_davinci/features/exercises/bindings/exercise_binding.dart';
import 'package:le_petit_davinci/features/exercises2/views/exercise.dart';
import 'package:le_petit_davinci/features/lessons3/bindings/lesson_bindings.dart';
import 'package:le_petit_davinci/features/lessons3/views/lesson.dart';

List<LevelConfig> generateLevelConfigsFromData() {
  final sortedLevels = unifiedEnglishLevels.keys.toList()..sort();

  //* Generate LevelConfig for each level
  return sortedLevels.map((level) {
    LevelType type;
    final levelContent = unifiedEnglishLevels[level];

    if (levelContent is LessonSet) {
      type = LevelType.lesson;
    } else {
      type = LevelType.exercise;
    }

    LevelStatus status = LevelStatus.inProgress;
    return LevelConfig(number: level, type: type, status: status);
  }).toList();
}

final List<LevelConfig> englishLevels = generateLevelConfigsFromData();

Widget? getLevelPage(int level) {
  final levelContent = unifiedEnglishLevels[level];

  if (levelContent is LessonSet) {
    return const LessonScreen3();
  } else if (levelContent is ExerciseSet) {
    return ExerciseScreen(
      exercises: levelContent.exercises,
      // exercises: levelContent.exercises,
      dialect: 'en-US',
    );
  }
  return null;
}

//* 4. Generate LevelModel list dynamically
List<Level> generateLevelModels(int start, int end) {
  final filteredLevels = englishLevels.where(
    (config) => config.number >= start && config.number <= end,
  );
  return filteredLevels.map((config) {
    final page = getLevelPage(config.number);
    VoidCallback? onTap;

    if (page != null) {
      if (page is LessonScreen3) {
        onTap = () => Get.to(() => page, binding: LessonBinding());
      } else if (page is ExerciseScreen) {
        final levelContent = unifiedEnglishLevels[config.number];

        // onTap =
        //     () => Get.to(
        //       () => page,
        //       binding: ExerciseBinding(),
        //     );
        if (levelContent is ExerciseSet) {
          onTap =
              () => Get.to(
                () => page,
                binding: ExerciseBinding(),
                // IMPORTANT: Pass the list of exercises as an argument.
                arguments: levelContent.exercises,
              );
        }
      } else {
        onTap = () => Get.to(() => page);
      }
    }

    return Level(
      levelType: config.type,
      levelStatus: config.status,
      onTap: onTap,
    );
  }).toList();
}

//* 5. Use in your SectionData (back to single section with mixed content)
final englishMapSections = [
  SectionData(
    color: AppColors.secondary,
    etapa: 1,
    seccion: 1,
    title: 'English Learning Path',
    levels: generateLevelModels(1, 9),
  ),
];
