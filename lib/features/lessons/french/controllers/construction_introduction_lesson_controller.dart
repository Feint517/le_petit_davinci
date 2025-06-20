 
import 'package:get/get.dart';

class ConstructionIntroductionLessonController extends GetxController {
  final selectedDay = 1.obs;
  
  final List<String> lessonOptions = List.generate(
    14, 
    (index) => "Construction des phrases simples ${index + 1}"
  );
  
  void changeSelectedDay(int day) {
    selectedDay.value = day;
  }
}