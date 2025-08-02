import 'package:get/get.dart';
import 'package:le_petit_davinci/features/lessons3/controllers/lessons_controller.dart';

class LessonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LessonsController3());
  }
}