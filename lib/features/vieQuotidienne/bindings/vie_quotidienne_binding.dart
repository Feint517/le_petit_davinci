import 'package:get/get.dart';
import 'package:le_petit_davinci/features/vieQuotidienne/controllers/vie_quotidienne_controller.dart';

class VieQuotidienneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VieQuotidienneController>(
      () => VieQuotidienneController(),
    );
  }
}
