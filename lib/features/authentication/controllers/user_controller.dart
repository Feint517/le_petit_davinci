// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:le_petit_davinci/core/styles/loaders.dart';
import 'package:le_petit_davinci/data/models/responses/user_data_response.dart';
import 'package:le_petit_davinci/data/models/user/user_data.dart';
import 'package:le_petit_davinci/data/repositories/user_repository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepo = UserRepository.instance;

  Rxn<UserData> user = Rxn<UserData>(); //* starts as null
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

      // print('============= data =========');
      // print(userDataResponse.data);
      // user.value.name = userDataResponse.data.name;
      // print('============= before affectation =========');
      // print('Name ==> ${userDataResponse.data.name}');

      // print('=============  affectation =========');
      user.value = userDataResponse.data;

      // print('============= after affectation =========');
      // print("Name ==> ${user.value!.name}");
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

  Future<void> testing() async {
    try {
      final UserDataResponse userDataResponse =
          await userRepo.fetchUserProfile();

      print('============= data =========');
      print(userDataResponse.data);

      print('=============  affectation =========');
      user.value = userDataResponse.data;

      print('============= after affectation =========');
      print(user.value!.french.progress);
    } catch (e) {
      CustomLoaders.showSnackBar(
        type: SnackBarType.error,
        title: 'Error',
        message: '$e',
      );
    }
  }
}
