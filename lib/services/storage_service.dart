import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxController {
  static StorageService get instance => Get.find();

  late final GetStorage localStorage;

  //* Initialize storage
  Future<void> init() async {
    await GetStorage.init();
    localStorage = GetStorage();
  }

  //* keys
  static const String isFirstTimeKey = 'is_first_time';
  static const String isLoggedInKey = 'is_logged_in';
  static const String authTokenKey = 'auth_token';

  //* Generic methods (if needed)
  T? read<T>(String key) => localStorage.read<T>(key);

  Future<void> write<T>(String key, T value) async =>
      await localStorage.write(key, value);

  Future<void> remove(String key) async => await localStorage.remove(key);

  Future<void> clear() async => await localStorage.erase();

  //? Get a list from storage (returns List<dynamic> or null)
  List<dynamic>? getList(String key) => localStorage.read<List<dynamic>>(key);

  // Set a list in storage
  Future<void> setList(String key, List<dynamic> value) async =>
      await localStorage.write(key, value);
}
