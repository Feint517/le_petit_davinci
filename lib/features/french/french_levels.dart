import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_model.dart';
import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_config_model.dart';

//* 1. List of level configs (just the number and type/status)
List<LevelConfig> generateLevelConfigsFromData() {
  final Set<int> allLevels = {};

  //* Collect all unique level numbers from unified data
  // allLevels.addAll(unifiedFrenchLevels.keys);

  //* Sort levels
  final sortedLevels = allLevels.toList()..sort();

  //* Generate LevelConfig for each level
  return sortedLevels.map((level) {
    LevelType type;
    // if (unifiedFrenchLevels.containsKey(level)) {
    //   type = LevelType.exercise;
    // } else {
    //   type = LevelType.lesson;

    // }

    type = LevelType.lesson;
    // You can set status dynamically or use a default
    LevelStatus status = LevelStatus.inProgress;

    return LevelConfig(
      number: level,
      title: 'Level $level',
      type: type,
      status: status,
    );
  }).toList();
}

final List<LevelConfig> frenchLevelConfigs = generateLevelConfigsFromData();

//* 2. Helper function to get the correct page for each level
Widget? getLevelPage(int level) {
  // if (unifiedFrenchLevels.containsKey(level)) {
  //   return ExerciseScreen(
  //     exercises: unifiedFrenchLevels[level]!,
  //     dialect: 'fr-FR', // French dialect
  //   );
  // } else if (level == 1) {
  //   // TODO: fix the french section
  //   // return const VideoLessonScreen(videoId: 'ccEpTTZW34g');
  //   return const Placeholder();
  // }
  return null; // ?Locked or not implemented
}

//* 3. Generate LevelModel list dynamically
List<Level> generateLevelModels(int start, int end) {
  final filteredConfigs = frenchLevelConfigs.where(
    (config) => config.number >= start && config.number <= end,
  );
  return filteredConfigs.map((config) {
    final page = getLevelPage(config.number);
    return Level(
      // title: config.title!,
      levelType: config.type,
      levelStatus: config.status,
      onTap: page != null ? () => Get.to(page) : null,
    );
  }).toList();
}

//* 4. Use in your SectionData
final frenchMapSections = [
  SectionData(
    color: AppColors.secondary,
    level: 1,
    section: 1,
    title: 'Les animaux',
    levels: generateLevelModels(1, 10),
  ),
];
