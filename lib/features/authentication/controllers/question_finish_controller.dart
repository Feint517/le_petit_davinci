import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionFinishController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late List<Animation<double>> fadeAnimations;

  final itemCount = 3;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    fadeAnimations = List.generate(itemCount, (index) {
      final start = index / itemCount;
      final end = (index + 1) / itemCount;
      return CurvedAnimation(
        parent: animationController,
        curve: Interval(start, end, curve: Curves.easeOut),
      );
    });

    //animationController.forward();
  }

  @override
  void onReady() {
    super.onReady();
    animationController.reset();
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
