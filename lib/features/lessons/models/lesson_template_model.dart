import 'package:le_petit_davinci/features/studio/models/artwork_model.dart';

/// Helper class to create templates for lesson drawing activities
class LessonTemplateHelper {
  static final List<String> _defaultColors = [
    'red',
    'blue',
    'green',
    'yellow',
    'orange',
    'purple',
    'pink',
    'brown',
  ];

  /// Create a template for letter drawing activity
  static TemplateModel createLetterTemplate({
    required String letter,
    required String instruction,
    String? language,
  }) {
    final isEnglish = language?.toLowerCase() == 'english';

    return TemplateModel(
      id: 'lesson_letter_${letter.toLowerCase()}',
      name: isEnglish ? 'Letter $letter' : 'Lettre $letter',
      previewImagePath:
          'assets/printables/letters/printable_${letter.toUpperCase()}.png', // same as templateImagePath if no separate preview
      templateImagePath:
          'assets/printables/letters/printable_${letter.toUpperCase()}.png',
      category: TemplateCategory.educational,
      difficulty: 1,
      colors: _defaultColors,
      educationalPrompt: instruction,
    );
  }

  /// Create a template for shape drawing activity
  static TemplateModel createShapeTemplate({
    required String shapeName,
    required String shapeId,
    required String instruction,
    String? language,
  }) {
    return TemplateModel(
      id: 'lesson_shape_$shapeId',
      name: shapeName,
      previewImagePath: 'assets/lesson_templates/shapes/${shapeId}_preview.png',
      templateImagePath:
          'assets/lesson_templates/shapes/${shapeId}_template.png',
      category: TemplateCategory.educational,
      difficulty: 1,
      colors: _defaultColors,
      educationalPrompt: instruction,
    );
  }

  /// Create a template for coloring activity
  static TemplateModel createColoringTemplate({
    required String id,
    required String title,
    required String templatePath,
    required String instruction,
    List<String>? suggestedColors,
  }) {
    return TemplateModel(
      id: 'lesson_coloring_$id',
      name: title,
      previewImagePath: templatePath.replaceAll('.png', '_preview.png'),
      templateImagePath: templatePath,
      category: TemplateCategory.educational,
      difficulty: 1,
      colors: suggestedColors ?? _defaultColors,
      educationalPrompt: instruction,
    );
  }

  /// Create a template for number drawing activity
  static TemplateModel createNumberTemplate({
    required String number,
    required String instruction,
    String? language,
  }) {
    final isEnglish = language?.toLowerCase() == 'english';

    return TemplateModel(
      id: 'lesson_number_$number',
      name: isEnglish ? 'Number $number' : 'Nombre $number',
      previewImagePath:
          'assets/lesson_templates/numbers/number_${number}_preview.png',
      templateImagePath:
          'assets/lesson_templates/numbers/number_${number}_template.png',
      category: TemplateCategory.educational,
      difficulty: 1,
      colors: _defaultColors,
      educationalPrompt: instruction,
    );
  }

  /// Create a custom template from activity data
  static TemplateModel fromDrawingActivity({
    required String activityId,
    required String title,
    required String templatePath,
    required String instruction,
    List<String>? colors,
    int? difficulty,
  }) {
    return TemplateModel(
      id: 'lesson_activity_$activityId',
      name: title,
      previewImagePath: templatePath.replaceAll('.png', '_preview.png'),
      templateImagePath: templatePath,
      category: TemplateCategory.educational,
      difficulty: difficulty ?? 1,
      colors: colors ?? _defaultColors,
      educationalPrompt: instruction,
    );
  }
}

/// Extension to make TemplateCategory work with lesson templates
extension TemplateCategoryExtension on TemplateCategory {
  static const educational =
      TemplateCategory.shapes; // Using shapes as placeholder for educational
}
