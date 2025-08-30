import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/data/models/section_data_model.dart';
import 'package:le_petit_davinci/features/english/english_levels.dart';

class EnglishMapController extends GetxController {
  final scrollController = ScrollController();
  final RxList<SectionData> mapSections = <SectionData>[].obs;

  // final mapSections = englishMapSections;

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
    // The 'englishMapSections' getter will re-run LevelUtils,
    // which fetches the latest data from ProgressService.
    mapSections.assignAll(englishMapSections);
  }
}
