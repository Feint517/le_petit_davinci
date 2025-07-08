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
      final UserDataResponse userDataResponse =
          await userRepo.fetchUserProfile();

      user.value = userDataResponse.data;
    } catch (e) {
      CustomLoaders.showSnackBar(
        type: SnackBarType.error,
        title: 'Error',
        message: '$e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
