import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/state_manager.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/features/Games/controllers/tic_tac_toe_controller.dart';

class TurnIndicator extends GetView<TicTacToeController> {
  const TurnIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            controller.isTurnO.value ? 'Tour du joueur' : ' Tour du joueur ',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.apply(color: AppColors.primary),
          ),

          const Gap(10),

          ResponsiveImageAsset(
            assetPath: controller.isTurnO.value ? SvgAssets.o : SvgAssets.x,
            width: 30,
          ),
        ],
      ),
    );
  }
}
