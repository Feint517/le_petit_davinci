import 'package:get/get.dart';
import 'package:le_petit_davinci/data/models/user_model.dart';
import 'package:le_petit_davinci/data/repositories/user_repository.dart';

class UserController extends GetxController {
  final UserRepository _userRepo = UserRepository();

  var user = Rxn<UserModel>();
  var isLoading = false.obs;

  Future<void> loadUserProfile() async {
    isLoading.value = true;
    try {
      user.value = await _userRepo.fetchUserProfile();
    } catch (e) {
      Get.snackbar("Error", "Failed to load user: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
