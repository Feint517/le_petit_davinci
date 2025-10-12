import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/home/views/home.dart';
import 'package:le_petit_davinci/features/leaderboard/views/leaderboard_screen.dart';
import 'package:le_petit_davinci/features/rewards/views/rewards.dart';

class MainNavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  final List<Widget> pages = [
    const HomeScreen(),
    const LeaderboardScreen(),
    const RewardsScreen(), // Using rewards as profile for now
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
