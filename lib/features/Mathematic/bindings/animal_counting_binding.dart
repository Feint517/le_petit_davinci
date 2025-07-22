// lib/features/Mathematic/bindings/animal_counting_binding.dart

import 'package:get/get.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/animal_counting_controller.dart';

class AnimalCountingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnimalCountingController>(
      () => AnimalCountingController(),
    );
  }
}