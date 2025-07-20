// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/features/Mathematic/models/level_model.dart';
import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';

class MathMapController extends GetxController {
  final scrollController = ScrollController();
  var isLoading = false.obs;

  final mapSections = [
    SectionData(
      color: Colors.blue,
      etapa: 1,
      seccion: 1,
      title: 'Preséntate',
      levels: [
        LevelModel(
          title: 'Level 1',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
        ),
        LevelModel(
          title: 'Level 2',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
        ),
        LevelModel(
          title: 'Level 3',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
        ),
        LevelModel(
          title: 'Level 4',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.inProgress,
        ),
        LevelModel(
          title: 'Level 5',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        LevelModel(
          title: 'Level 6',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        LevelModel(
          title: 'Level 7',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        LevelModel(
          title: 'Level 8',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        LevelModel(
          title: 'Level 9',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
      ],
    ),
    SectionData(
      color: Colors.orange,
      etapa: 1,
      seccion: 2,
      title: "Usa el tiempo presente",
      levels: [
        LevelModel(
          title: 'Level 1',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        LevelModel(
          title: 'Level 2',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        LevelModel(
          title: 'Level 3',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        LevelModel(
          title: 'Level 4',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        LevelModel(
          title: 'Level 5',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        LevelModel(
          title: 'Level 6',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        LevelModel(
          title: 'Level 7',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        LevelModel(
          title: 'Level 8',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        LevelModel(
          title: 'Level 9',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
      ],
    ),
  ];

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
