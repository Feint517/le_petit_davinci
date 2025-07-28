// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_model.dart';
import 'package:le_petit_davinci/features/Mathematic/models/section_data_model.dart';
import 'package:le_petit_davinci/features/Mathematic/view/animal_counting_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/candy_shop_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/market_balance_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/number_puzzle_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/math_additions_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/math_subtraction_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/math_geometry_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/shape_architect_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/shape_detective_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/tidy_room_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/treasure_chest_screen.dart';

class MathMapController extends GetxController {
  final scrollController = ScrollController();
  var isLoading = false.obs;
  final mapSections = [
    SectionData(
      color: Colors.blue,
      etapa: 1,
      seccion: 1,
      title: 'Calculs', // Changed to French
      levels: [
        Level(
          // title: 'Puzzle des Nombres',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const NumberPuzzleScreen()),
        ),
        Level(
          // title: 'Les Additions Magiques',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const MathAdditionsScreen()),
        ),
        Level(
          // title: 'Les Soustractions en Mission',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const MathSubtractionScreen()),
        ),
        Level(
          // title: 'Magasin des Bonbons',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const CandyShopScreen()),
        ),
        Level(
          // title: 'La Chambre Rangée', // Changed to French
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const TidyRoomScreen()),
        ),
        Level(
          // title: 'Le Coffre au Trésor', // Changed to French
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const TreasureChestScreen()),
        ),
        Level(
          // title: 'L\'Équilibre du Marché', // Changed to French
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.inProgress,
          onTap: () => Get.to(() => const MarketBalanceScreen()),
        ),
        Level(
          // title: 'Compter avec les Animaux',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const AnimalCountingScreen()),
        ),
        Level(
          // title: 'Le Comptage des Animaux', // Changed to French
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
      ],
    ),
    SectionData(
      color: Colors.orange,
      etapa: 1,
      seccion: 2,
      title: "Géométrie", // Changed to French
      levels: [
        Level(
          //title: 'Le Jeu des Formes Géométriques',
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const MathGeometryScreen()),
        ),
        Level(
          //title: 'L\'Architecte des Formes', // Changed to French
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const ShapeArchitectScreen()),
        ),
        Level(
          // title: 'Le Détective des Formes', // Changed to French
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.completed,
          onTap: () => Get.to(() => const ShapeDetectiveScreen()),
        ),
        Level(
          // title: 'La Géométrie Mathématique', // Changed to French
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        Level(
          //title: 'L\'Architecte des Formes', // Changed to French
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        Level(
          // title: 'Le Détective des Formes', // Changed to French
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        Level(
          //  title: 'La Chambre Rangée', // Changed to French
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        Level(
          // title: 'Le Coffre au Trésor', // Changed to French
          levelType: LevelType.lesson,
          levelStatus: LevelStatus.locked,
        ),
        Level(
          //title: 'L\'Équilibre du Marché', // Changed to French
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
