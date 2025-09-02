import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/data/models/section_data_model.dart';
import 'package:le_petit_davinci/features/math/math_levels.dart';

class MathMapController2 extends GetxController {
  final scrollController = ScrollController();
  final RxList<SectionData> mapSections = <SectionData>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load the data when the controller is first initialized.
    loadMapData();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void loadMapData() {
    mapSections.assignAll(mathMapSections);
  }
}
