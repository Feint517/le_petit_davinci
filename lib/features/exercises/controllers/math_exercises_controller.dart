import 'package:get/get.dart';
import 'package:le_petit_davinci/features/exercises/models/math_exercise_model.dart';
import 'package:le_petit_davinci/features/math/data/math_levels.dart';

class MathExercisesController extends GetxController {
  final currentLevel = 1.obs;
  final currentExerciseIndex = 0.obs;
  final exercises = <MathExercise>[].obs;
  final isCompleted = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadExercisesForLevel(currentLevel.value);
  }

  void loadExercisesForLevel(int level) {
    final levelContent = mathLevels[level];

    if (levelContent is MathExerciseSet) {
      exercises.value = levelContent.exercises;
      currentExerciseIndex.value = 0;
      isCompleted.value = false;
    }
  }

  MathExercise? get currentExercise {
    if (exercises.isEmpty || currentExerciseIndex.value >= exercises.length) {
      return null;
    }
    return exercises[currentExerciseIndex.value];
  }

  void nextExercise() {
    if (currentExerciseIndex.value < exercises.length - 1) {
      currentExerciseIndex.value++;
    } else {
      isCompleted.value = true;
    }
  }

  bool get hasNextExercise => currentExerciseIndex.value < exercises.length - 1;

  double get progress =>
      exercises.isEmpty
          ? 0.0
          : (currentExerciseIndex.value + 1) / exercises.length;
}
