import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_config_model.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_model.dart';
import 'package:le_petit_davinci/data/models/subject/level_content.dart';
import 'package:le_petit_davinci/features/exercises/controllers/exercises_controller.dart';
import 'package:le_petit_davinci/features/exercises/views/exercise.dart';
import 'package:le_petit_davinci/features/lessons/controllers/lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons/views/lesson.dart';
import 'package:le_petit_davinci/services/progress_service.dart';


class LevelUtils {
  /// Generates level configs from the provided content map
  static List<LevelConfig> generateLevelConfigsFromData<T>(
    Map<int, T> contentMap,
  ) {
    final sortedLevels = contentMap.keys.toList()..sort();

    return sortedLevels.map((level) {
      final levelContent = contentMap[level];
      final type =
          (levelContent is LessonSet) ? LevelType.lesson : LevelType.exercise;

      return LevelConfig(
        number: level,
        type: type,
        status: LevelStatus.inProgress,
      );
    }).toList();
  }

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

      final unlocked = ProgressService.instance.isUnlocked(
        language,
        config.number,
      );
      final hasStars =
          ProgressService.instance.getStars(language, config.number) > 0;
      final status =
          unlocked
              ? (hasStars ? LevelStatus.completed : LevelStatus.inProgress)
              : LevelStatus.locked;

      // Only wire onTap when unlocked.
      if (unlocked) {
        onTap = () {
          // --- REFACTORED NAVIGATION LOGIC ---
          final levelContent = contentMap[config.number];

          if (levelContent is LessonSet) {
            // Navigate to the LessonScreen using a binding to inject the controller.
            Get.to(
              () => const LessonScreen(),
              binding: BindingsBuilder(() {
                Get.put(
                  LessonsController(
                    lessonData: levelContent.lesson,
                    levelNumber: config.number,
                    language: language,
                  ),
                );
              }),
            );
          } else if (levelContent is ExerciseSet) {
            // Navigate to the ExerciseScreen using a binding to inject the controller.
            Get.to(
              () => const ExerciseScreen(),
              binding: BindingsBuilder(() {
                Get.put(
                  ExercisesController(
                    exercises: levelContent.exercises,
                    levelNumber: config.number,
                    language: language,
                    dialect: dialect,
                  ),
                );
              }),
            );
          }
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
