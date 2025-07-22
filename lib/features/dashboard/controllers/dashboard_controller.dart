import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/data/repositories/authentication_repository.dart';
import 'package:le_petit_davinci/features/authentication/controllers/user_controller.dart';
import 'package:le_petit_davinci/features/authentication/views/login.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/services/storage_service.dart';

class DashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final userController = UserController.instance;

  // Try to get StudioController if it exists, otherwise create it
  StudioController? get studioController {
    try {
      return Get.find<StudioController>();
    } catch (e) {
      return Get.put(StudioController());
    }
  }

  final textController = TextEditingController();
  final capsuleName = TextEditingController();
  final capsuleText = TextEditingController();
  RxInt selectedAthorizedTime = 10.obs;
  RxString selectedPrefferedLanguage = 'fr'.obs;
  RxBool blockAfterTime = false.obs;
  RxBool authorizeWithPin = false.obs;
  RxBool makeCapsuleVisible = false.obs;

  final List<Map<String, dynamic>> authorizedTimeOoptions = [
    {'label': '5 min', 'value': 5},
    {'label': '10 min', 'value': 10},
    {'label': '15 min', 'value': 15},
    {'label': '30 min', 'value': 30},
    {'label': 'Illimité', 'value': -1},
  ];

  //* times percentages
  double? frenchTimePercentage;
  double? englishTimePercentage;
  double? mathTimePercentage;
  double? dailyLifeTimePercentage;
  double? gamesTimePercentage;
  double? studioTimePercentage; // Added Studio time tracking
  int totalTime = 0;

  //* Studio stats
  RxInt totalArtworks = 0.obs;
  RxInt sharedArtworks = 0.obs;
  RxInt weeklyArtworks = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await calculateTimePercentages();
    await loadStudioStats();
  }

  Future<void> calculateTimePercentages() async {
    final french =
        double.tryParse(userController.user.value!.french.timeSpent) ?? 0;
    final english =
        double.tryParse(userController.user.value!.english.timeSpent) ?? 0;
    final math =
        double.tryParse(userController.user.value!.math.timeSpent) ?? 0;
    final dailyLife = 210.0;
    final games = 111.0;
    final studio = await getStudioTimeSpent(); // Get Studio time

    final totalTime = french + english + math + dailyLife + games + studio;

    if (totalTime > 0) {
      frenchTimePercentage = (french / totalTime) * 100;
      englishTimePercentage = (english / totalTime) * 100;
      mathTimePercentage = (math / totalTime) * 100;
      dailyLifeTimePercentage = (dailyLife / totalTime) * 100;
      gamesTimePercentage = (games / totalTime) * 100;
      studioTimePercentage = (studio / totalTime) * 100; // Studio percentage
    }
  }

  Future<void> loadStudioStats() async {
    final studio = studioController;
    if (studio != null) {
      await studio.loadArtworks();

      totalArtworks.value = studio.artworks.length;
      sharedArtworks.value =
          studio.artworks.where((artwork) => artwork.isSharedWithParent).length;

      // Calculate weekly artworks
      final now = DateTime.now();
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      weeklyArtworks.value =
          studio.artworks
              .where((artwork) => artwork.createdAt.isAfter(startOfWeek))
              .length;
    }
  }

  Future<double> getStudioTimeSpent() async {
    // Calculate time spent in Studio based on artwork creation
    final studio = studioController;
    if (studio != null) {
      // Estimate 10 minutes per artwork as base time
      return studio.artworks.length * 10.0;
    }
    return 0.0;
  }

  int calculateTotalTime() {
    final french =
        double.tryParse(userController.user.value!.french.timeSpent) ?? 0;
    final english =
        double.tryParse(userController.user.value!.english.timeSpent) ?? 0;
    final math =
        double.tryParse(userController.user.value!.math.timeSpent) ?? 0;
    final dailyLife = 210.0;
    final games = 111.0;

    final totalTimeMinutes = french + english + math + dailyLife + games;

    final hours = totalTimeMinutes ~/ 60;

    totalTime = hours;
    return totalTime;
  }

  // Get Studio activity summary for parent dashboard
  Map<String, dynamic> getStudioSummary() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);

    final studio = studioController;
    if (studio == null) {
      return {
        'totalArtworks': 0,
        'sharedArtworks': 0,
        'monthlyArtworks': 0,
        'recentActivity': <String>[],
        'favoriteColors': <String>[],
      };
    }

    final monthlyArtworks =
        studio.artworks
            .where((artwork) => artwork.createdAt.isAfter(startOfMonth))
            .length;

    final recentActivity =
        studio.artworks
            .take(5)
            .map(
              (artwork) =>
                  'Dessin "${artwork.title}" créé le ${_formatDate(artwork.createdAt)}',
            )
            .toList();

    // Extract favorite colors from metadata (would be more sophisticated in real implementation)
    final favoriteColors = ['Rouge', 'Bleu', 'Vert']; // Placeholder

    return {
      'totalArtworks': studio.artworks.length,
      'sharedArtworks':
          studio.artworks.where((a) => a.isSharedWithParent).length,
      'monthlyArtworks': monthlyArtworks,
      'recentActivity': recentActivity,
      'favoriteColors': favoriteColors,
    };
  }

  void logout() async {
    final response = await AuthenticationRepository.instance.logout(id: 123);
    if (response.status == 0) {
      StorageService.instance.clear();
      Get.offAll(() => const LoginScreen());
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
