import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:le_petit_davinci/features/home/views/home_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //* variables
  final deviceStorage = GetStorage();

  @override
  void onReady() {
    screenRedirect(); //? redirect to the appropriate screen
  }

  void screenRedirect() {
    Get.to(() => const HomeScreen());
  }
}
