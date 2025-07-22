// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/features/Mathematic/models/level_model.dart';
import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';
import 'package:le_petit_davinci/features/english/models/level_config_model.dart';
import 'package:le_petit_davinci/features/exercises/data/fill_the_blank_data.dart';
import 'package:le_petit_davinci/features/exercises/data/listen_and_choose_data.dart';
import 'package:le_petit_davinci/features/exercises/data/reorder_words_data.dart';
import 'package:le_petit_davinci/features/exercises/views/fill_the_blank.dart';
import 'package:le_petit_davinci/features/exercises/views/listen_and_choose.dart';
import 'package:le_petit_davinci/features/exercises/views/reorder_words.dart';
import 'package:le_petit_davinci/features/french/view/video_lesson.dart';

//* 1. List of level configs (just the number and type/status)
final List<LevelConfig> levelConfigs = [
  LevelConfig(
    number: 1,
    title: 'Level 1',
    type: LevelType.lesson,
    status: LevelStatus.inProgress,
  ),
  LevelConfig(
    number: 2,
    title: 'Level 2',
    type: LevelType.exercise,
    status: LevelStatus.completed,
  ),
  LevelConfig(
    number: 3,
    title: 'Level 3',
    type: LevelType.exercise,
    status: LevelStatus.completed,
  ),
  LevelConfig(
    number: 4,
    title: 'Level 4',
    type: LevelType.exercise,
    status: LevelStatus.inProgress,
  ),
  LevelConfig(
    number: 5,
    title: 'Level 5',
    type: LevelType.lesson,
    status: LevelStatus.inProgress,
  ),
  LevelConfig(
    number: 6,
    title: 'Level 6',
    type: LevelType.lesson,
    status: LevelStatus.inProgress,
  ),
  LevelConfig(
    number: 7,
    title: 'Level 7',
    type: LevelType.lesson,
    status: LevelStatus.inProgress,
  ),
  LevelConfig(
    number: 8,
    title: 'Level 8',
    type: LevelType.lesson,
    status: LevelStatus.inProgress,
  ),
  LevelConfig(
    number: 9,
    title: 'Level 9',
    type: LevelType.lesson,
    status: LevelStatus.inProgress,
  ),
  LevelConfig(
    number: 10,
    title: 'Level 10',
    type: LevelType.lesson,
    status: LevelStatus.inProgress,
  ),
  LevelConfig(
    number: 11,
    title: 'Level 11',
    type: LevelType.lesson,
    status: LevelStatus.inProgress,
  ),
  LevelConfig(
    number: 12,
    title: 'Level 12',
    type: LevelType.lesson,
    status: LevelStatus.inProgress,
  ),
  LevelConfig(
    number: 13,
    title: 'Level 13',
    type: LevelType.lesson,
    status: LevelStatus.inProgress,
  ),
  LevelConfig(
    number: 14,
    title: 'Level 14',
    type: LevelType.lesson,
    status: LevelStatus.inProgress,
  ),
];

//* 2. Helper function to get the correct page for each level
Widget? getLevelPage(int level) {
  if (fillTheBlankEnglishLevels.containsKey(level)) {
    return FillTheBlankScreen(exercises: fillTheBlankEnglishLevels[level]!);
  } else if (listenAndChooseEnglishLevels.containsKey(level)) {
    return ListenAndChooseScreen(exercises: listenAndChooseEnglishLevels[level]!);
  } else if (reorderWordsEnglishLevels.containsKey(level)) {
    return ReorderWordsScreen(exercises: reorderWordsEnglishLevels[level]!);
  } else if (level == 1) {
    return const VideoLessonScreen(videoId: 'ccEpTTZW34g');
  }
  return null; // ?Locked or not implemented
}

//* 3. Generate LevelModel list dynamically
List<LevelModel> generateLevelModels(int start, int end) {
  final filteredConfigs = levelConfigs.where(
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
    levels: generateLevelModels(1, 5),
  ),
  SectionData(
    color: AppColors.primary,
    etapa: 1,
    seccion: 2,
    title: 'Things around us',
    levels: generateLevelModels(6, 14),
  ),
  SectionData(
    color: AppColors.primary,
    etapa: 1,
    seccion: 2,
    title: 'Things around us',
    levels: generateLevelModels(6, 14),
  ),
];
