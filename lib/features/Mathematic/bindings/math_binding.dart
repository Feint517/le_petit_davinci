import 'package:get/get.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/math_map_controller.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/math_map_controller_old.dart';

class MathBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MathMapController());
  }
}
