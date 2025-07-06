import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/custom_shapes/container/curved_header_container.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/core/widgets/layouts/grid_layout.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';
import 'package:le_petit_davinci/features/Games/models/game_model.dart';
import 'package:le_petit_davinci/features/Games/view/snake.dart';
import 'package:le_petit_davinci/features/Games/view/tic_tac_toe_intro.dart';
import 'package:le_petit_davinci/features/Games/widgets/game_card.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const ProfileHeader(
                  userName: 'Alex',
                  userClass: 'Class 2',
                  showTrailingIcon: false,
                ),
                const Divider(
                  color: AppColors.grey,
                  thickness: 1.5,
                  indent: 30,
                  endIndent: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.defaultSpace,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(AppSizes.spaceBtwItems),
                      const CustomNavBar(
                        activeChip: true,
                        variant: BadgeVariant.games,
                      ),
                      const Gap(AppSizes.spaceBtwItems),
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
                        mainAxisExtent: 250,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          final List<GameModel> gamesList = [
                            GameModel(
                              name: 'Tic Tac Toe',
                              numOfVictories: 5,
                              color: AppColors.primaryDeep,
                              icon: SvgAssets.tictactoe,
                              gameScreen: const TicTacToeIntroScreen(),
                            ),
                            GameModel(
                              name: 'Échecs simplifiés',
                              numOfVictories: 2,
                              color: AppColors.accent,
                              icon: SvgAssets.chess,
                              gameScreen: const SnakeGame(),
                            ),
                            GameModel(
                              name: 'Suites logiques',
                              numOfVictories: 0,
                              color: AppColors.accent2,
                              icon: SvgAssets.biscuit,
                              gameScreen: const Placeholder(),
                            ),
                          ];
                          return GameCard(
                            cardColor: gamesList[index].color,
                            label: gamesList[index].numOfVictories,
                            title: gamesList[index].name,
                            assetPath: gamesList[index].icon,
                            onTap:
                                () => Get.to(() => gamesList[index].gameScreen),
                          );
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
