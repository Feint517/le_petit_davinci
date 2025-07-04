import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreateProfileController extends GetxController {
  final kidName = TextEditingController();
  final selectedYear = Rx<String?>(null);
  final selectedLanguage = Rx<String?>(null);
  final selectedTime = Rx<int?>(null);
}
