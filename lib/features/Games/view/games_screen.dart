import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/custom_shapes/container/curved_header_container.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/core/widgets/layouts/grid_layout.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/Games/models/game_model.dart';
import 'package:le_petit_davinci/features/Games/view/snake.dart';
import 'package:le_petit_davinci/features/Games/view/chess_game.dart';
import 'package:le_petit_davinci/features/Games/view/tic_tac_toe_intro.dart';
import 'package:le_petit_davinci/features/Games/widgets/game_card.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const ProfileHeader(type: ProfileHeaderType.compact),
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          CustomCurvedHeaderContainer(
            backgroundColor: AppColors.primary,
            height: DeviceUtils.getScreenHeight() * 0.5,
          ),
          Positioned(
            bottom: 0,
            child: const ResponsiveImageAsset(
              assetPath: SvgAssets.gamesBackground2,
            ),
          ),
          SizedBox.expand(
            child: Column(
              children: [
                Gap(DeviceUtils.getAppBarHeight() + AppSizes.defaultSpace),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.defaultSpace,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(AppSizes.spaceBtwItems * 2),
                      Text(
                        "C'est l'heure de s'amuser !\nChoisis ton jeu préféré !",
                        style: Theme.of(context).textTheme.headlineMedium!
                            .apply(color: AppColors.white),
                      ),
                      Text(
                        'Glisser les bons objets dans un sac.',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.apply(color: AppColors.white),
                      ),
                      const Gap(AppSizes.spaceBtwSections),
                      CustomGridLayout(
                        spacing: AppSizes.spaceBtwItems,
                        childAspectRatio: 0.8,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          final List gamesList = [
                            GameModel(
                              name: 'Tic Tac Toe',
                              numOfVictories: 5,
                              color: AppColors.primaryDeep,
                              icon: SvgAssets.tictactoe,
                              goToGameScreen:
                                  () => Get.to(
                                    () => const TicTacToeIntroScreen(),
                                  ),
                            ),
                            GameModel(
                              name: 'le serpent',
                              numOfVictories: 2,
                              color: AppColors.accent,
                              icon: SvgAssets.chess,
                              goToGameScreen:
                                  () => Get.to(() => const SnakeGame()),
                            ),
                            GameModel(
                              name: 'Échecs simplifiés',
                              numOfVictories: 2,
                              color: AppColors.accent,
                              icon: SvgAssets.chess,
                              goToGameScreen:
                                  () => Get.to(() => const ChessGame()),
                            ),
                          ];
                          return GameCard(gameModel: gamesList[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
