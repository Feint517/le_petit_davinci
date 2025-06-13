import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/features/lessons/widget/find_the_word.dart';
import 'package:le_petit_davinci/features/lessons/widget/listen_and_match.dart';
import 'package:le_petit_davinci/features/lessons/widget/word_builder.dart';

class PracticeContent extends StatelessWidget {
  final PracticeType type;
  const PracticeContent({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case PracticeType.listenAndMatch:
        return const ListenAndMatch();
      case PracticeType.wordBuilder:
        return const WordBuilder();
      case PracticeType.findTheWord:
        return const FindTheWord();
    }
  }
}
