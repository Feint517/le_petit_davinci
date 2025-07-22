import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/french/french_levels.dart';

class FrenchMapController extends GetxController {
  final scrollController = ScrollController();
  var isLoading = false.obs;

  final mapSections = frenchMapSections;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
