import 'package:get/get.dart';
import 'package:le_petit_davinci/features/exercises/controllers/unified_exercise_controller.dart';

class ExerciseBinding extends Bindings {
  @override
  void dependencies() {
    final exerciseData = Get.arguments;
    // Use lazyPut to create the controller only when the screen is built.
    Get.lazyPut(() => UnifiedExerciseController(dialect: 'en-US', exerciseData));
  }
}
