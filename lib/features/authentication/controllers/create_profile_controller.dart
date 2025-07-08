import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/authentication/views/create_profile.dart';

class CreateProfileController extends GetxController {
  final kidName = TextEditingController();
  final selectedYear = Rx<String?>(null);
  final selectedLanguage = Rx<String?>(null);
  final selectedTime = Rx<int?>(null);

  var selectedCardIndex = RxInt(-1); // -1 means nothing selected

  final List<ProfileData> profiles = [
    ProfileData(
      name: 'Alex',
      subInfo: 'class 2',
      image: SvgAssets.avatar1,
      backgroundColor: AppColors.primary,
    ),
    ProfileData(
      name: 'Alex',
      subInfo: 'class 2',
      image: SvgAssets.avatar2,
      backgroundColor: AppColors.secondary,
    ),
    ProfileData(
      name: 'Alex',
      subInfo: 'class 2',
      image: SvgAssets.avatar3,
      backgroundColor: AppColors.accent,
    ),
    ProfileData(
      name: 'Alex',
      subInfo: 'class 2',
      image: SvgAssets.avatar4,
      backgroundColor: AppColors.accent3,
    ),
  ];

  void selectProfile(int index) {
    selectedCardIndex.value = index;
  }
}
