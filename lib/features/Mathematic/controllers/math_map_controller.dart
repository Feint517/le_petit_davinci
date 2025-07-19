// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MathMapController extends GetxController {
  var levels = <String>[].obs;
  final scrollController = ScrollController();
  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    loadMoreLevels();

    scrollController.addListener(() {
  if (scrollController.position.pixels >=
      scrollController.position.maxScrollExtent - 100 &&
      !isLoading.value) {
    loadMoreLevels();
  }
});
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void loadMoreLevels() {
  if (isLoading.value) return;
  isLoading.value = true;
  Future.delayed(Duration(seconds: 2), () {
    print('add new levels called');
    levels.addAll(
      List.generate(20, (index) => 'Level ${levels.length + index + 1}'),
    );
    isLoading.value = false;
  });
}
}
