import 'package:get/get.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';

class StudioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudioController>(() => StudioController());
  }
}