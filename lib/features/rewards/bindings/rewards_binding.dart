import 'package:get/get.dart';
import 'package:le_petit_davinci/features/rewards/controllers/rewards_controller.dart';

class RewardsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RewardsController>(() => RewardsController());
  }
}