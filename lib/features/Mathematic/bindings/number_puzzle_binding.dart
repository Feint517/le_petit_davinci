// lib/features/Mathematic/bindings/number_puzzle_binding.dart

import 'package:get/get.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/number_puzzle_controller.dart';

class NumberPuzzleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NumberPuzzleController>(
      () => NumberPuzzleController(),
    );
  }
}