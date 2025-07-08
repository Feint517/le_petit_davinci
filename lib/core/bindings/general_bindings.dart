import 'package:get/get.dart';
import 'package:le_petit_davinci/core/network/network_manager.dart';
import 'package:le_petit_davinci/data/repositories/authentication_repository.dart';
import 'package:le_petit_davinci/data/repositories/user_repository.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(UserRepository());
    Get.lazyPut<AuthenticationRepository>(() => AuthenticationRepository());
  }
}
