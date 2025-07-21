import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/features/Mathematic/models/level_model.dart';
import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';
import 'package:le_petit_davinci/features/lessons/english/widget/word_builder.dart';
import 'package:le_petit_davinci/features/english/view/listen_and_match.dart';
import 'package:le_petit_davinci/features/lessons/english/widget/find_the_word.dart';

class EnglishMapController extends GetxController {
  // final GlobalKey svgKey = GlobalKey();

  // final RxDouble _svgRenderedWidth = RxDouble(0.0);
  // final RxDouble _svgRenderedHeight = RxDouble(0.0);

  // double? get svgRenderedWidth =>
  //     _svgRenderedWidth.value == 0.0 ? null : _svgRenderedWidth.value;
  // double? get svgRenderedHeight =>
  //     _svgRenderedHeight.value == 0.0 ? null : _svgRenderedHeight.value;

  // void getSvgDimensions() {
  //   if (svgKey.currentContext != null) {
  //     final RenderBox renderBox =
  //         svgKey.currentContext!.findRenderObject() as RenderBox;
  //     _svgRenderedWidth.value = renderBox.size.width;
  //     _svgRenderedHeight.value = renderBox.size.height;
  //     if (kDebugMode) {
  //       print('SVG dimensions: ${renderBox.size}');
  //     }
  //   } else {
  //     if (kDebugMode) {
  //       print(
  //         'Controller: Warning: svgKey.currentContext is null. Could not get dimensions.',
  //       );
  //     }
  //   }
  // }
  final scrollController = ScrollController();
  var isLoading = false.obs;

  final mapSections = [
    SectionData(
      color: Colors.blue,
      etapa: 1,
      seccion: 1,
      title: 'Calculations',
      levels: [
        LevelModel(
          title: 'Level 1',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.inProgress,
          content: const WordBuilder(),
        ),
        LevelModel(
          title: 'Level 2',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.inProgress,
          content: const ListenAndMatch(),
        ),
        LevelModel(
          title: 'Level 3',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.inProgress,
          content: const FindTheWord(),
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
      title: "Geometry",
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
