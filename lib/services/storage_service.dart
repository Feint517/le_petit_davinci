import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxController {
  static StorageService get instance => Get.find();

  late final GetStorage locacStorage;

  //* Initialize storage
  Future<void> init() async {
    await GetStorage.init();
    locacStorage = GetStorage();
  }

  //* keys
  static const String isFirstTimeKey = 'is_first_time';
  static const String isLoggedInKey = 'is_logged_in';
  static const String authTokenKey = 'auth_token';

  //* Generic methods (if needed)
  T? read<T>(String key) => locacStorage.read<T>(key);

  Future<void> write<T>(String key, T value) async =>
      await locacStorage.write(key, value);

  Future<void> remove(String key) async => await locacStorage.remove(key);

  Future<void> clear() async => await locacStorage.erase();
}
