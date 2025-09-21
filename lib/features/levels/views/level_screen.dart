import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';
import 'package:le_petit_davinci/features/levels/widgets/level_app_bar.dart';
import 'package:le_petit_davinci/features/levels/widgets/level_bottom_bar.dart';
import 'package:le_petit_davinci/features/levels/widgets/level_content_view.dart';

class LevelScreen extends GetView<LevelController> {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LevelAppBar(),
      body: const LevelContentView(),
      bottomNavigationBar: const LevelBottomBar(),
    );
  }
}
