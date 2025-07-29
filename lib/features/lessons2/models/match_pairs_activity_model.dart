import 'package:le_petit_davinci/features/lessons2/models/lesson_model.dart';

class MatchPairsActivity extends LessonActivity {
  final List<MatchPair> pairs;

  const MatchPairsActivity({
    required super.id,
    required super.title,
    required super.instruction,
    required this.pairs,
  }) : super(type: ActivityType.matchPairs);
}

class MatchPair {
  final String id;
  final String leftItem;
  final String rightItem;
  final String? leftImagePath;
  final String? rightImagePath;

  const MatchPair({
    required this.id,
    required this.leftItem,
    required this.rightItem,
    this.leftImagePath,
    this.rightImagePath,
  });
}
