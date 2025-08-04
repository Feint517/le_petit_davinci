import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Icon(Icons.star_rounded, color: Colors.amber, size: 150),
            ResponsiveImageAsset(assetPath: SvgAssets.bearMasscot, height: 150),
            const Gap(20),
            Text(
              'Lesson Complete!',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Gap(10),
            const Text(
              'Great job! You are a true artist!',
              style: TextStyle(fontSize: 16),
            ),
            const Gap(50),
            CustomButton(
              variant: ButtonVariant.secondary,
              label: 'Finish',
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
