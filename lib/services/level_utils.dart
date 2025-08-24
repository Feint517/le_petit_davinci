import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_config_model.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_model.dart';
import 'package:le_petit_davinci/data/models/subject/level_content.dart';
import 'package:le_petit_davinci/features/exercises/views/exercise.dart';
import 'package:le_petit_davinci/features/lessons/views/lesson.dart';
import 'package:le_petit_davinci/services/progress_service.dart';

/// Utility class to generate level data for different subjects
class LevelUtils {
  /// Generates level configs from the provided content map
  static List<LevelConfig> generateLevelConfigsFromData<T>(
    Map<int, T> contentMap,
  ) {
    final sortedLevels = contentMap.keys.toList()..sort();

    return sortedLevels.map((level) {
      final levelContent = contentMap[level];
      // final type = (levelContent is LessonSet)
      //     ? LevelType.lesson
      //     : LevelType.exercise;
      final type =
          (levelContent is LessonSet) ? LevelType.lesson : LevelType.exercise;

      return LevelConfig(
        number: level,
        type: type,
        status: LevelStatus.inProgress,
      );
    }).toList();
  }

  /// Gets the appropriate page for a level
  static Widget? getLevelPage(
    Map<int, LevelContent> contentMap,
    int level,
    String language,
    String dialect,
  ) {
    final levelContent = contentMap[level];

    if (levelContent is LessonSet) {
      return LessonScreen(lesson: levelContent.lesson);
    } else if (levelContent is ExerciseSet) {
      return ExerciseScreen(
        exercises: levelContent.exercises,
        dialect: dialect,
        levelNumber: level,
        language: language,
      );
    }
    return null;
  }

  /// Generates level models for a range of levels
  static List<Level> generateLevelModels<T extends LevelContent>({
    required List<LevelConfig> levelConfigs,
    required Map<int, T> contentMap,
    required int start,
    required int end,
    required String language,
    required String dialect,
  }) {
    final filteredLevels = levelConfigs.where(
      (config) => config.number >= start && config.number <= end,
    );

    return filteredLevels.map((config) {
      VoidCallback? onTap;

      // Safe unlock check (works even if ProgressService isn't registered yet)
      final unlocked =
          Get.isRegistered<ProgressService>()
              ? ProgressService.instance.isUnlocked(language, config.number)
              : (config.number == 1);

      final hasStars =
          Get.isRegistered<ProgressService>()
              ? ProgressService.instance.getStars(language, config.number) > 0
              : false;

      final status =
          unlocked
              ? (hasStars ? LevelStatus.completed : LevelStatus.inProgress)
              : LevelStatus.locked;

      // Only wire onTap when unlocked; build the page at tap-time
      if (unlocked) {
        onTap = () {
          final page = getLevelPage(
            contentMap,
            config.number,
            language,
            dialect,
          );
          if (page != null) Get.to(() => page);
        };
      }

      return Level(
        levelType: config.type,
        levelStatus: status,
        onTap: onTap,
        number: config.number,
      );
    }).toList();
  }
}
