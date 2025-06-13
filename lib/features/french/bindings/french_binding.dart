import 'package:get/get.dart';
import 'package:le_petit_davinci/features/french/controller/french_map_controller.dart';

class FrenchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FrenchMapController());
  }
}
