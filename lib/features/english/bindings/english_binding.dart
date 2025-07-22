import 'package:get/get.dart';
import 'package:le_petit_davinci/features/english/controllers/english_map_controller.dart';

class EnglishBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EnglishMapController());
  }
}
