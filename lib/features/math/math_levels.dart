// ignore_for_file: constant_identifier_names
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_config_model.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_model.dart';
import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';
import 'package:le_petit_davinci/features/math/data/math_levels.dart';
import 'package:le_petit_davinci/services/level_utils.dart';

// Constants for Math subject
const String MATH_LANG_CODE = 'math';
const String MATH_DIALECT = 'en-US';

// Generate configs using the utility
// Replace unifiedMathLevels with your actual math content map
final List<LevelConfig> mathLevels = LevelUtils.generateLevelConfigsFromData(
  unifiedMathLevels,
);

// Generate level models for a specific range
List<Level> generateMathLevelModels(int start, int end) {
  return LevelUtils.generateLevelModels(
    levelConfigs: mathLevels,
    contentMap: unifiedMathLevels,
    start: start,
    end: end,
    language: MATH_LANG_CODE,
    dialect: MATH_DIALECT,
  );
}

// Math-specific sections
List<SectionData> get mathMapSections => [
  SectionData(
    color: AppColors.orangeAccent,
    level: 1,
    section: 1,
    title: 'Numbers',
    levels: generateMathLevelModels(1, 10),
  ),
  SectionData(
    color: AppColors.primary,
    level: 1,
    section: 2,
    title: 'Shapes',
    levels: generateMathLevelModels(11, 20),
  ),
];
