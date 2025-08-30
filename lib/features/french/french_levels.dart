// ignore_for_file: constant_identifier_names
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_config_model.dart';
import 'package:le_petit_davinci/data/models/section_data_model.dart';
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
