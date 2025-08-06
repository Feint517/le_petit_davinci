import 'package:get/get.dart';
import 'package:le_petit_davinci/features/exercises2/controllers/exercises_controller.dart';

class ExerciseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExercisesController(dialect: 'en-US', exercises: []));
  }
}
