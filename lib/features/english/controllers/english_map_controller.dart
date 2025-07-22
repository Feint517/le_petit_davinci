import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/english/english_levels.dart';

class EnglishMapController extends GetxController {
  final scrollController = ScrollController();
  var isLoading = false.obs;

  final mapSections = englishMapSections;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
