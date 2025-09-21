// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_config_model.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_model.dart';
import 'package:le_petit_davinci/data/models/subject/level_content.dart';
import 'package:le_petit_davinci/features/levels/controllers/victory_controller.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';
import 'package:le_petit_davinci/features/levels/views/level_screen.dart';
import 'package:le_petit_davinci/services/progress_service.dart';

class LevelUtils {
  /// Generates level configs from the provided content map
  static List<LevelConfig> generateLevelConfigsFromData<T>(
    Map<int, T> contentMap,
  ) {
    final sortedLevels = contentMap.keys.toList()..sort();

    return sortedLevels.map((level) {
      // With the new unified system, all levels are LevelSet with activities
      // No distinction between lessons and exercises - everything is activities
      final type =
          LevelType
              .exercise; // All levels are now treated as exercise-type for navigation

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
          // --- UNIFIED NAVIGATION LOGIC ---
          final levelContent = contentMap[config.number];

          // Determine subject for the level
          Subjects subject;
          switch (language) {
            case 'french':
              subject = Subjects.french;
              break;
            case 'math':
              subject = Subjects.math;
              break;
            case 'english':
            default:
              subject = Subjects.english;
          }

          // All levels now use the unified LevelController and LevelScreen
          if (levelContent is LevelContent) {
            Get.to(
              () => const LevelScreen(),
              binding: BindingsBuilder(() {
                Get.put(
                  LevelController(
                    content: levelContent,
                    levelNumber: config.number,
                    language: language,
                    subject: subject,
                    dialect: dialect,
                  ),
                );
              }),
            );
          } else {
            print(
              'Warning: Level ${config.number} content is not a valid LevelContent',
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
