import 'package:le_petit_davinci/features/levels/models/activities/multiple_choice_activity.dart';
import 'package:le_petit_davinci/features/levels/models/selectable_option_model.dart';

/// Example demonstrating how to create and use the enhanced MultipleChoiceActivity
class MultipleChoiceUsageExample {
  /// Example 1: Multiple Choice with Network Images
  static MultipleChoiceActivity createAnimalQuiz() {
    return MultipleChoiceActivity(
      question: 'Which animals are carnivores?',
      instruction: 'Select all the carnivorous animals from the list below.',
      options: [
        SelectableOption(
          label: 'Lion',
          imagePath:
              'https://images.unsplash.com/photo-1546182990-dffeafbe841d?w=300&h=300&fit=crop',
          isNetworkImage: true,
        ),
        SelectableOption(
          label: 'Rabbit',
          imagePath:
              'https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?w=300&h=300&fit=crop',
          isNetworkImage: true,
        ),
        SelectableOption(
          label: 'Tiger',
          imagePath:
              'https://images.unsplash.com/photo-1561731216-c3a4d99437d5?w=300&h=300&fit=crop',
          isNetworkImage: true,
        ),
        SelectableOption(
          label: 'Cow',
          imagePath:
              'https://images.unsplash.com/photo-1560114928-40f1f1eb26a0?w=300&h=300&fit=crop',
          isNetworkImage: true,
        ),
      ],
      correctIndices: [0, 2], // Lion and Tiger are carnivores
    );
  }

  /// Example 2: Multiple Choice with Local Assets
  static MultipleChoiceActivity createFruitQuiz() {
    return MultipleChoiceActivity(
      question: 'Which fruits are citrus?',
      instruction: 'Choose all the citrus fruits.',
      options: [
        SelectableOption(
          label: 'Orange',
          imagePath: 'assets/images/illustrations/orange.png', // Local asset
          isNetworkImage: false,
        ),
        SelectableOption(
          label: 'Apple',
          imagePath: 'assets/images/illustrations/apple.png', // Local asset
          isNetworkImage: false,
        ),
        SelectableOption(
          label: 'Lemon',
          imagePath: 'assets/images/illustrations/lemon.png', // Local asset
          isNetworkImage: false,
        ),
        SelectableOption(
          label: 'Banana',
          imagePath: 'assets/images/illustrations/banana.png', // Local asset
          isNetworkImage: false,
        ),
      ],
      correctIndices: [0, 2], // Orange and Lemon are citrus
    );
  }

  /// Example 3: Single Answer Multiple Choice
  static MultipleChoiceActivity createCapitalQuiz() {
    return MultipleChoiceActivity(
      question: 'What is the largest planet in our solar system?',
      instruction: 'Select the correct answer.',
      options: [
        SelectableOption(
          label: 'Earth',
          imagePath:
              'https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?w=300&h=300&fit=crop',
          isNetworkImage: true,
        ),
        SelectableOption(
          label: 'Jupiter',
          imagePath:
              'https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?w=300&h=300&fit=crop',
          isNetworkImage: true,
        ),
        SelectableOption(
          label: 'Mars',
          imagePath:
              'https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?w=300&h=300&fit=crop',
          isNetworkImage: true,
        ),
        SelectableOption(
          label: 'Venus',
          imagePath:
              'https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?w=300&h=300&fit=crop',
          isNetworkImage: true,
        ),
      ],
      correctIndices: [1], // Jupiter is the largest planet
    );
  }

  /// Example 4: Mixed Network and Local Assets
  static MultipleChoiceActivity createMixedAssetsQuiz() {
    return MultipleChoiceActivity(
      question: 'Which items are typically found in a kitchen?',
      instruction: 'Select all items commonly found in kitchens.',
      options: [
        SelectableOption(
          label: 'Refrigerator',
          imagePath:
              'https://images.unsplash.com/photo-1571175443880-49e1d25b2bc5?w=300&h=300&fit=crop',
          isNetworkImage: true,
        ),
        SelectableOption(
          label: 'Bed',
          imagePath: 'assets/images/illustrations/bed.png',
          isNetworkImage: false,
        ),
        SelectableOption(
          label: 'Stove',
          imagePath:
              'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=300&h=300&fit=crop',
          isNetworkImage: true,
        ),
        SelectableOption(
          label: 'Sink',
          imagePath:
              'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=300&h=300&fit=crop',
          isNetworkImage: true,
        ),
      ],
      correctIndices: [
        0,
        2,
        3,
      ], // Refrigerator, Stove, and Sink are kitchen items
    );
  }
}

/// Usage Instructions:
///
/// 1. Create a MultipleChoiceActivity with your desired options
/// 2. Add it to a LevelSet in your level content
/// 3. The activity will automatically handle:
///    - Network image loading with error handling
///    - Local asset loading
///    - Answer validation
///    - User feedback (correct/incorrect)
///    - Mascot introduction
///
/// Key Features:
/// - Supports both network images and local assets
/// - Multiple selection capability
/// - Proper validation and feedback
/// - Responsive UI with loading states
/// - Error handling for failed image loads
/// - Integration with the existing level system




