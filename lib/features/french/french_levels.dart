// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/core/constants/colors.dart';
// import 'package:le_petit_davinci/core/constants/enums.dart';
// import 'package:le_petit_davinci/data/models/lessons&exercises/level_model.dart';
// import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';
// import 'package:le_petit_davinci/data/models/lessons&exercises/level_config_model.dart';
// import 'package:le_petit_davinci/features/french/data/level_content.dart';
// import 'package:le_petit_davinci/features/exercises/views/exercise.dart';
// import 'package:le_petit_davinci/features/lessons/views/lesson.dart';
// import 'package:le_petit_davinci/services/progress_service.dart';

// //* 1. List of level configs (just the number and type/status)
// List<LevelConfig> generateLevelConfigsFromData() {
//   final sortedLevels = unifiedFrenchLevels.keys.toList()..sort();

//   //* Generate LevelConfig for each level
//   return sortedLevels.map((level) {
//     // LevelType type;
//     final levelContent = unifiedFrenchLevels[level];

//     // if (levelContent is LessonSet) {
//     //   type = LevelType.lesson;
//     // } else {
//     //   type = LevelType.exercise;
//     // }
//     final type =
//         (levelContent is LessonSet) ? LevelType.lesson : LevelType.exercise;

//     // LevelStatus status = LevelStatus.inProgress;
//     final status = LevelStatus.inProgress;

//     return LevelConfig(number: level, type: type, status: status);
//   }).toList();
// }

// final List<LevelConfig> frenchLevels = generateLevelConfigsFromData();

// //* 2. Helper function to get the correct page for each level
// Widget? getLevelPage(int level) {
//   final levelContent = unifiedFrenchLevels[level];

//   if (levelContent is LessonSet) {
//     return LessonScreen(lesson: levelContent.lesson);
//   } else if (levelContent is ExerciseSet) {
//     return ExerciseScreen(
//       exercises: levelContent.exercises,
//       dialect: 'fr-FR',
//       levelNumber: level,
//       language: 'fr',
//     );
//   }
//   return null;
// }

// //* 3. Generate LevelModel list dynamically
// List<Level> generateLevelModels(int start, int end) {
//   final filtered = frenchLevels.where(
//     (config) => config.number >= start && config.number <= end,
//   );
//   return filtered.map((config) {
//     // final page = getLevelPage(config.number);
//     VoidCallback? onTap;

//     // Safe unlock check (works even if ProgressService isn’t registered yet)
//     final unlocked =
//         Get.isRegistered<ProgressService>()
//             ? ProgressService.instance.isUnlocked('en', config.number)
//             : (config.number == 1);

//     // Only wire onTap when unlocked; build the page at tap-time
//     onTap =
//         (unlocked)
//             ? () {
//               final page = getLevelPage(config.number);
//               if (page != null) Get.to(() => page);
//             }
//             : null;

//     return Level(
//       levelType: config.type,
//       levelStatus: config.status,
//       onTap: onTap,
//     );
//   }).toList();
// }

// //* 4. Use in your SectionData
// final frenchMapSections = [
//   SectionData(
//     color: AppColors.secondary,
//     level: 1,
//     section: 1,
//     title: 'Les Alphabets',
//     levels: generateLevelModels(1, 21),
//   ),
//   SectionData(
//     color: AppColors.accent,
//     level: 1,
//     section: 1,
//     title: 'Les animaux',
//     levels: generateLevelModels(22, 30),
//   ),
// ];

// ignore_for_file: constant_identifier_names

import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_config_model.dart';
import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';
import 'package:le_petit_davinci/features/french/data/level_content.dart';
import 'package:le_petit_davinci/services/level_utils.dart';

import '../../data/models/lessons&exercises/level_model.dart';

// Constants for French subject
const String FRENCH_LANG_CODE = 'fr';
const String FRENCH_DIALECT = 'fr-FR';

// Generate configs using the utility
final List<LevelConfig> frenchLevels = LevelUtils.generateLevelConfigsFromData(
  unifiedFrenchLevels,
);

// Generate level models for a specific range
List<Level> generateFrenchLevelModels(int start, int end) {
  return LevelUtils.generateLevelModels(
    levelConfigs: frenchLevels,
    contentMap: unifiedFrenchLevels,
    start: start,
    end: end,
    language: FRENCH_LANG_CODE,
    dialect: FRENCH_DIALECT,
  );
}

// Sections are subject-specific
final List<SectionData> frenchMapSections = [
  SectionData(
    color: AppColors.secondary,
    level: 1,
    section: 1,
    title: 'Les Alphabets',
    levels: generateFrenchLevelModels(1, 21),
  ),
  SectionData(
    color: AppColors.accent,
    level: 1,
    section: 1,
    title: 'Les animaux',
    levels: generateFrenchLevelModels(22, 30),
  ),
];
