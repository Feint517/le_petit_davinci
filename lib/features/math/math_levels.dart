import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_model.dart';
import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_config_model.dart';
import 'package:le_petit_davinci/features/english/data/level_content.dart';
import 'package:le_petit_davinci/features/exercises/views/exercise.dart';
import 'package:le_petit_davinci/features/lessons/views/lesson.dart';
import 'package:le_petit_davinci/services/progress_service.dart';

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
    return LessonScreen(lesson: levelContent.lesson);
  } else if (levelContent is ExerciseSet) {
    return ExerciseScreen(
      exercises: levelContent.exercises,
      dialect: 'en-US',
      levelNumber: level,
      language: 'en',
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

    final unlocked = ProgressService.instance.isUnlocked('en', config.number);
    final hasStars = ProgressService.instance.getStars('en', config.number) > 0;
    final status =
        unlocked
            ? (hasStars ? LevelStatus.completed : LevelStatus.inProgress)
            : LevelStatus.locked;

    if (page != null) {
      if (page is LessonScreen) {
        onTap = () => Get.to(() => page);
      } else if (page is ExerciseScreen) {
        final levelContent = unifiedEnglishLevels[config.number];
        if (levelContent is ExerciseSet) {
          onTap = () => Get.to(() => page);
        }
      } else {
        onTap = () => Get.to(() => page);
      }
    }

    return Level(
      levelType: config.type,
      levelStatus: status,
      onTap: onTap,
    );
  }).toList();
}

//? getter so it recalculates on each access
List<SectionData> get mathMapSections => [
  SectionData(
    color: AppColors.secondary,
    level: 1,
    section: 1,
    title: 'The Alphabets',
    levels: generateLevelModels(1, 21),
  ),
  SectionData(
    color: AppColors.accent,
    level: 1,
    section: 1,
    title: 'The animals',
    levels: generateLevelModels(22, 30),
  ),
];
