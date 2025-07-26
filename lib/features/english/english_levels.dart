import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/features/Mathematic/models/level_model.dart';
import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';
import 'package:le_petit_davinci/features/english/models/level_config_model.dart';
import 'package:le_petit_davinci/features/exercises/data/unified_exercise_data.dart';
import 'package:le_petit_davinci/features/exercises/views/unified_exercise.dart';
import 'package:le_petit_davinci/features/french/view/video_lesson.dart';

//* 1. List of level configs (just the number and type/status)
List<LevelConfig> generateLevelConfigsFromData() {
  final Set<int> allLevels = {};

  //* Collect all unique level numbers from unified data
  allLevels.addAll(unifiedEnglishLevels.keys);

  //* Sort levels
  final sortedLevels = allLevels.toList()..sort();

  //* Generate LevelConfig for each level
  return sortedLevels.map((level) {
    LevelType type;
    if (unifiedEnglishLevels.containsKey(level)) {
      type = LevelType.exercise;
    } else {
      type = LevelType.lesson;
    }

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

final List<LevelConfig> englishLevelConfigs = generateLevelConfigsFromData();

//* 2. Helper function to get the correct page for each level
Widget? getLevelPage(int level) {
  if (unifiedEnglishLevels.containsKey(level)) {
    return UnifiedExerciseScreen(
      exercises: unifiedEnglishLevels[level]!,
      dialect: 'en-US', //? Default to English dialect
    );
  } else if (level == 1) {
    return const VideoLessonScreen(videoId: 'ccEpTTZW34g');
  }
  return null; // ?Locked or not implemented
}

//* 3. Generate LevelModel list dynamically
List<LevelModel> generateLevelModels(int start, int end) {
  final filteredConfigs = englishLevelConfigs.where(
    (config) => config.number >= start && config.number <= end,
  );
  return filteredConfigs.map((config) {
    final page = getLevelPage(config.number);
    return LevelModel(
      title: config.title,
      levelType: config.type,
      levelStatus: config.status,
      onTap: page != null ? () => Get.to(page) : null,
    );
  }).toList();
}

//* 4. Use in your SectionData
final englishMapSections = [
  SectionData(
    color: AppColors.secondary,
    etapa: 1,
    seccion: 1,
    title: 'Animals',
    levels: generateLevelModels(1, 10),
  ),
];
