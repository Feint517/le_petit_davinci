import 'package:le_petit_davinci/core/constants/enums.dart';

class LevelConfig {
  LevelConfig({
    required this.number,
    required this.title,
    required this.type,
    required this.status,
  });

  final int number;
  final String title;
  final LevelType type;
  final LevelStatus status;
}
