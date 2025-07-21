// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/market_balance_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/models/level_model.dart';
import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';
import 'package:le_petit_davinci/features/Mathematic/view/animal_counting_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/candy_shop_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/number_puzzle_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/math_additions_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/math_subtraction_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/math_geometry_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/tidy_room_screen.dart';

class MathMapController extends GetxController {
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
          title: 'Compter avec les Animaux',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const AnimalCountingScreen()),
        ),
        LevelModel(
          title: 'Puzzle des Nombres',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const NumberPuzzleScreen()),
        ),
        LevelModel(
          title: 'Les Additions Magiques',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const MathAdditionsScreen()),
        ),
        LevelModel(
          title: 'Les Soustractions en Mission',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const MathSubtractionScreen()),
        ),
        LevelModel(
          title: 'Magasin des Bonbons',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const CandyShopScreen()),
        ),
        LevelModel(
          title: 'Level 6',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const TidyRoomScreen()),
        ),
        LevelModel(
          title: 'Level 7',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const MarketBalanceScreen()),
        ),
        LevelModel(
          title: 'Level 8',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const TidyRoomScreen()),
        ),
        LevelModel(
          title: 'Level 9',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
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
          title: 'Le Jeu des Formes Géométriques',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const MathGeometryScreen()),
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
