import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_model.dart';
import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_config_model.dart';
import 'package:le_petit_davinci/features/exercises/data/unified_exercise_data.dart';
import 'package:le_petit_davinci/features/exercises/views/unified_exercise.dart';
import 'package:le_petit_davinci/features/lessons/views/lesson_screen.dart';
import 'package:le_petit_davinci/features/lessons/data/lessons_data.dart';

//* 2. List of level configs (just the number and type/status)
List<LevelConfig> generateLevelConfigsFromData() {
  final Set<int> allLevels = {};

  //* Collect all unique level numbers from unified data (exercises)
  allLevels.addAll(unifiedEnglishLevels.keys);

  //* Add lesson levels from the defined map
  allLevels.addAll(englishLessons.keys);

  //* Sort levels
  final sortedLevels = allLevels.toList()..sort();

  //* Generate LevelConfig for each level
  return sortedLevels.map((level) {
    LevelType type;

    if (englishLessons.containsKey(level)) {
      //? This is a lesson level
      type = LevelType.lesson;
    } else if (unifiedEnglishLevels.containsKey(level)) {
      //? This is an exercise level
      type = LevelType.exercise;
      // title = 'Exercise $level';
    } else {
      //? Default case
      type = LevelType.exercise;
      // title = 'Level $level';
    }
    // if (unifiedEnglishLevels.containsKey(level)) {
    //   //? This is an exercise level
    //   type = LevelType.exercise;
    //   // title = 'Exercise $level';
    // } else {
    //   //? Default case
    //   type = LevelType.exercise;
    //   // title = 'Level $level';
    // }

    LevelStatus status = LevelStatus.inProgress;

    return LevelConfig(number: level, type: type, status: status);
  }).toList();
}

final List<LevelConfig> englishLevels = generateLevelConfigsFromData();

Widget? getLevelPage(int level) {
  if (englishLessons.containsKey(level)) {
    return LessonScreen(lesson: englishLessons[level]!);
  } else if (unifiedEnglishLevels.containsKey(level)) {
    return UnifiedExerciseScreen(
      exercises: unifiedEnglishLevels[level]!,
      dialect: 'en-US', //? Default to English dialect
    );
  }
  // if (unifiedEnglishLevels.containsKey(level)) {
  //   return UnifiedExerciseScreen(
  //     exercises: unifiedEnglishLevels[level]!,
  //     dialect: 'en-US', //? Default to English dialect
  //   );
  // }
  return null; //? Locked or not implemented
}

//* 4. Generate LevelModel list dynamically
List<Level> generateLevelModels(int start, int end) {
  final filteredLevels = englishLevels.where(
    (config) => config.number >= start && config.number <= end,
  );
  return filteredLevels.map((config) {
    final page = getLevelPage(config.number);
    return Level(
      // title: config.title!,
      levelType: config.type,
      levelStatus: config.status,
      onTap: page != null ? () => Get.to(page) : null,
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
