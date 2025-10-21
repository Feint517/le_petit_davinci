import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/data/models/subject/level_content.dart';
import 'package:le_petit_davinci/features/levels/models/activities/activities.dart';
import 'package:le_petit_davinci/features/levels/models/selectable_option_model.dart';

/// Sample level demonstrating the enhanced MultipleChoiceActivity
/// with network assets, questions, and proper validation
final Map<int, LevelContent> multipleChoiceSampleLevels = {
  1: LevelSet(
    title: 'Animal Recognition Quiz',
    introduction: 'Test your knowledge of animals with this interactive quiz!',
    activities: [
      // Multiple Choice with Network Images
      MultipleChoiceActivity(
        question: 'Which of these animals are mammals?',
        instruction: 'Select all the correct answers. You can choose multiple options.',
        options: [
          SelectableOption(
            label: 'Dog',
            imagePath: 'https://images.unsplash.com/photo-1552053831-71594a27632d?w=300&h=300&fit=crop',
            isNetworkImage: true,
          ),
          SelectableOption(
            label: 'Eagle',
            imagePath: 'https://images.unsplash.com/photo-1551085254-e96b210db58b?w=300&h=300&fit=crop',
            isNetworkImage: true,
          ),
          SelectableOption(
            label: 'Cat',
            imagePath: 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=300&h=300&fit=crop',
            isNetworkImage: true,
          ),
          SelectableOption(
            label: 'Shark',
            imagePath: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=300&h=300&fit=crop',
            isNetworkImage: true,
          ),
        ],
        correctIndices: [0, 2], // Dog and Cat are mammals
      ),

      // Multiple Choice with Local Assets
      MultipleChoiceActivity(
        question: 'Which fruits are red?',
        instruction: 'Choose all the red fruits from the options below.',
        options: [
          SelectableOption(
            label: 'Apple',
            imagePath: ImageAssets.apple,
            isNetworkImage: false,
          ),
          SelectableOption(
            label: 'Banana',
            imagePath: ImageAssets.banana,
            isNetworkImage: false,
          ),
          SelectableOption(
            label: 'Cherry',
            imagePath: 'https://images.unsplash.com/photo-1518635017498-87f514b751ba?w=300&h=300&fit=crop',
            isNetworkImage: true,
          ),
          SelectableOption(
            label: 'Strawberry',
            imagePath: 'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?w=300&h=300&fit=crop',
            isNetworkImage: true,
          ),
        ],
        correctIndices: [0, 2, 3], // Apple, Cherry, and Strawberry are red
      ),

      // Single Answer Multiple Choice
      MultipleChoiceActivity(
        question: 'What is the capital of France?',
        instruction: 'Select the correct answer.',
        options: [
          SelectableOption(
            label: 'London',
            imagePath: 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?w=300&h=300&fit=crop',
            isNetworkImage: true,
          ),
          SelectableOption(
            label: 'Paris',
            imagePath: 'https://images.unsplash.com/photo-1502602898536-47ad22581b52?w=300&h=300&fit=crop',
            isNetworkImage: true,
          ),
          SelectableOption(
            label: 'Berlin',
            imagePath: 'https://images.unsplash.com/photo-1587330979470-3595ac045ab0?w=300&h=300&fit=crop',
            isNetworkImage: true,
          ),
          SelectableOption(
            label: 'Madrid',
            imagePath: 'https://images.unsplash.com/photo-1539037116277-4db20889f2d4?w=300&h=300&fit=crop',
            isNetworkImage: true,
          ),
        ],
        correctIndices: [1], // Paris is the correct answer
      ),
    ],
  ),

  2: LevelSet(
    title: 'Math Concepts Quiz',
    introduction: 'Test your understanding of basic math concepts!',
    activities: [
      // Math Multiple Choice with Network Images
      MultipleChoiceActivity(
        question: 'Which shapes have 4 sides?',
        instruction: 'Select all shapes that have exactly 4 sides.',
        options: [
          SelectableOption(
            label: 'Triangle',
            imagePath: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300&h=300&fit=crop',
            isNetworkImage: true,
          ),
          SelectableOption(
            label: 'Square',
            imagePath: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300&h=300&fit=crop',
            isNetworkImage: true,
          ),
          SelectableOption(
            label: 'Rectangle',
            imagePath: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300&h=300&fit=crop',
            isNetworkImage: true,
          ),
          SelectableOption(
            label: 'Circle',
            imagePath: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300&h=300&fit=crop',
            isNetworkImage: true,
          ),
        ],
        correctIndices: [1, 2], // Square and Rectangle have 4 sides
      ),
    ],
  ),
};








