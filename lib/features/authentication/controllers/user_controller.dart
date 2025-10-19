import 'package:get/get.dart';
import 'package:le_petit_davinci/core/styles/loaders.dart';
import 'package:le_petit_davinci/data/models/responses/user_data_response.dart';
import 'package:le_petit_davinci/data/models/user/user_data.dart';
import 'package:le_petit_davinci/data/repositories/user_repository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepo = UserRepository.instance;

  Rxn<UserData> user = Rxn<UserData>(); //? starts as null
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecords();
  }

  Future<void> fetchUserRecords() async {
    isLoading.value = true;
    try {
      print('👤 [UserController] Fetching user records');
      final UserDataResponse userDataResponse =
          await userRepo.fetchUserProfile();

      user.value = userDataResponse.data;
      print('👤 [UserController] User records fetched successfully');
    } catch (e) {
      print('👤 [UserController] Error fetching user records: $e');
      // Don't show error popup on home screen load
      // Just log the error for debugging
    } finally {
      isLoading.value = false;
    }
  }
}
