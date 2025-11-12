import 'package:get/get.dart';
import 'package:le_petit_davinci/data/models/auth/profile.dart';
import 'package:le_petit_davinci/data/models/responses/user_data_response.dart';
import 'package:le_petit_davinci/data/models/user/user_data.dart';
import 'package:le_petit_davinci/data/repositories/user_repository.dart';
import 'package:le_petit_davinci/services/storage_service.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepo = UserRepository.instance;
  final _storage = StorageService.instance;

  Rxn<UserData> user = Rxn<UserData>(); //? starts as null
  var isLoading = false.obs;

  // Observable profile - updates when profile is selected
  Rxn<Profile> selectedProfile = Rxn<Profile>();

  @override
  void onInit() {
    super.onInit();
    // Load profile from storage
    _loadProfile();
    // Only fetch if profile is already selected
    if (selectedProfile.value != null) {
      fetchUserRecords();
    } else {
      print('👤 [UserController] No profile selected yet, skipping fetch');
    }
  }

  // Load profile from storage
  void _loadProfile() {
    final profile = _storage.getSelectedProfile();
    selectedProfile.value = profile;
    if (profile != null) {
      print('👤 [UserController] Loaded profile: ${profile.profileName}');
    }
  }

  // Call this method when profile is selected (e.g., after PIN validation)
  void onProfileSelected() {
    _loadProfile();
    if (selectedProfile.value != null) {
      fetchUserRecords();
    }
  }

  Future<void> fetchUserRecords() async {
    // Check if profile is selected before fetching
    if (selectedProfile.value == null) {
      print('👤 [UserController] Cannot fetch user records: No profile selected');
      return;
    }

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
