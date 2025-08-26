// ignore_for_file: constant_identifier_names
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_config_model.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_model.dart';
import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';
import 'package:le_petit_davinci/features/english/data/level_content.dart';
import 'package:le_petit_davinci/services/level_utils.dart';

// Constants for English subject
const String ENGLISH_LANG_CODE = 'en';
const String ENGLISH_DIALECT = 'en-US';

// Generate configs using the utility
final List<LevelConfig> englishLevels = LevelUtils.generateLevelConfigsFromData(
  unifiedEnglishLevels,
);

// Generate level models for a specific range
List<Level> generateEnglishLevelModels(int start, int end) {
  return LevelUtils.generateLevelModels(
    levelConfigs: englishLevels,
    contentMap: unifiedEnglishLevels,
    start: start,
    end: end,
    language: ENGLISH_LANG_CODE,
    dialect: ENGLISH_DIALECT,
  );
}

// Sections getter remains subject-specific
List<SectionData> get englishMapSections => [
  SectionData(
    color: AppColors.secondary,
    level: 1,
    section: 1,
    title: 'The Alphabets',
    levels: generateEnglishLevelModels(1, 21),
  ),
  SectionData(
    color: AppColors.accent,
    level: 1,
    section: 1,
    title: 'The animals',
    levels: generateEnglishLevelModels(22, 30),
  ),
];
