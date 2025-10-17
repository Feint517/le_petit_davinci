import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:le_petit_davinci/data/models/auth/supabase_session.dart';
import 'package:le_petit_davinci/data/models/auth/profile.dart';

class StorageService extends GetxController {
  static StorageService get instance => Get.find();

  late final GetStorage localStorage;

  //* Initialize storage
  Future<void> init() async {
    await GetStorage.init();
    localStorage = GetStorage();
  }

  //* Storage keys
  static const String isFirstTimeKey = 'is_first_time';
  static const String isLoggedInKey = 'is_logged_in';

  // Supabase session keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String sessionKey = 'session';
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';

  // Profile keys
  static const String selectedProfileKey = 'selected_profile';
  static const String profileTokenKey = 'profile_token';
  static const String profilesKey = 'profiles';

  //* Generic methods
  T? read<T>(String key) => localStorage.read<T>(key);

  Future<void> write<T>(String key, T value) async =>
      await localStorage.write(key, value);

  Future<void> remove(String key) async => await localStorage.remove(key);

  Future<void> clear() async => await localStorage.erase();

  List<dynamic>? getList(String key) => localStorage.read<List<dynamic>>(key);

  Future<void> setList(String key, List<dynamic> value) async =>
      await localStorage.write(key, value);

  //* Session management methods
  Future<void> saveSession(SupabaseSession session) async {
    await write(accessTokenKey, session.accessToken);
    await write(refreshTokenKey, session.refreshToken);
    await write(sessionKey, session.toJson());
    await write(userIdKey, session.user.id);
    await write(userEmailKey, session.user.email);
    await write(isLoggedInKey, true);
  }

  String? getAccessToken() => read<String>(accessTokenKey);

  String? getRefreshToken() => read<String>(refreshTokenKey);

  String? getUserId() => read<String>(userIdKey);

  String? getUserEmail() => read<String>(userEmailKey);

  bool isLoggedIn() => read<bool>(isLoggedInKey) ?? false;

  //* Profile management methods
  Future<void> saveProfiles(List<Profile> profiles) async {
    await write(profilesKey, profiles.map((p) => p.toJson()).toList());
  }

  List<Profile>? getProfiles() {
    final profilesData = getList(profilesKey);
    if (profilesData == null) return null;
    return profilesData
        .map((json) => Profile.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveSelectedProfile(Profile profile) async {
    await write(selectedProfileKey, profile.toJson());
  }

  Profile? getSelectedProfile() {
    final profileData = read<Map<String, dynamic>>(selectedProfileKey);
    if (profileData == null) return null;
    return Profile.fromJson(profileData);
  }

  Future<void> saveProfileToken(String token) async {
    await write(profileTokenKey, token);
  }

  String? getProfileToken() => read<String>(profileTokenKey);

  //* Clear all auth data on logout
  Future<void> clearAuthData() async {
    await remove(accessTokenKey);
    await remove(refreshTokenKey);
    await remove(sessionKey);
    await remove(userIdKey);
    await remove(userEmailKey);
    await remove(selectedProfileKey);
    await remove(profileTokenKey);
    await remove(profilesKey);
    await write(isLoggedInKey, false);
  }
}
