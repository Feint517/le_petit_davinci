import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
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
}
