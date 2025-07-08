// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/authentication/controllers/user_controller.dart';

class DashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final userController = UserController.instance;

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
  int totalTime = 0;

  @override
  void onInit() async {
    super.onInit();
    await calculateTimePercentages();
    //await calculateTotalTime();
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

    final totalTime = french + english + math + dailyLife + games;

    frenchTimePercentage = (french / totalTime) * 100;
    englishTimePercentage = (english / totalTime) * 100;
    mathTimePercentage = (math / totalTime) * 100;
    dailyLifeTimePercentage = (dailyLife / totalTime) * 100;
    gamesTimePercentage = (games / totalTime) * 100;
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
    // final minutes = totalTimeMinutes % 60;

    totalTime = hours;
    return totalTime;
  }
}
