import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/math/math_levels.dart';

class MathMapController2 extends GetxController {
  final scrollController = ScrollController();
  var isLoading = false.obs;

  final mapSections = mathMapSections;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
