import 'package:get/get.dart';
import 'package:le_petit_davinci/features/exercises/controllers/math_exercises_controller.dart';

class MathExercisesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MathExercisesController>(
      () => MathExercisesController(),
    );
  }
}