import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';
import 'package:le_petit_davinci/features/Games/controllers/tic_tac_toe_controller.dart';
import 'package:le_petit_davinci/features/Games/view/tic_tac_toe.dart';

class TicTacToeIntroScreen extends StatelessWidget {
  const TicTacToeIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TicTacToeController());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: const ResponsiveImageAsset(
                assetPath: SvgAssets.tictactoeIntroBackground,
              ),
            ),
            SizedBox.expand(
              child: Column(
                children: [
                  const CustomNavBar(
                    activeChip: true,
                    chipText: 'Tic Tac Toe',
                    chipColor: AppColors.accent,
                  ),
                  const Gap(AppSizes.spaceBtwSections),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.defaultSpace,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '2 victoires',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                Text(
                                  'Tic-Tac-Toe',
                                  style:
                                      Theme.of(
                                        context,
                                      ).textTheme.headlineMedium,
                                ),

                                const Gap(AppSizes.spaceBtwItems),

                                Container(
                                  width:
                                      DeviceUtils.getScreenWidth() -
                                      (AppSizes.defaultSpace * 2),
                                  //height: 500,
                                  padding: EdgeInsets.all(AppSizes.md),
                                  decoration: BoxDecoration(
                                    color: AppColors.accentDark,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width:
                                            DeviceUtils.getScreenWidth() -
                                            (AppSizes.defaultSpace * 2),
                                        height:
                                            DeviceUtils.getScreenWidth() -
                                            (AppSizes.defaultSpace * 3.3),
                                        decoration: BoxDecoration(
                                          color: AppColors.accent,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(40),
                                          ),
                                        ),
                                        child: Table(
                                          border: TableBorder(
                                            horizontalInside: const BorderSide(
                                              width: 1,
                                              color: AppColors.white,
                                            ),
                                            verticalInside: const BorderSide(
                                              width: 1,
                                              color: AppColors.white,
                                            ),
                                          ),
                                          children: List.generate(3, (row) {
                                            return TableRow(
                                              children: List.generate(3, (col) {
                                                return AspectRatio(
                                                  aspectRatio: 1,
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    alignment: Alignment.center,
                                                    child:
                                                        (row == 0 && col == 0)
                                                            ? ResponsiveImageAsset(
                                                              assetPath:
                                                                  SvgAssets.x,
                                                              width: 48,
                                                            )
                                                            : (row == 2 &&
                                                                col == 2)
                                                            ? ResponsiveImageAsset(
                                                              assetPath:
                                                                  SvgAssets.o,
                                                              width: 48,
                                                            )
                                                            : const SizedBox.shrink(), // You can put your X/O or buttons here
                                                  ),
                                                );
                                              }),
                                            );
                                          }),
                                        ),
                                      ),

                                      const Gap(AppSizes.spaceBtwItems),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomButton(
                                            variant: ButtonVariant.secondary,
                                            label: 'Jouer avec la mascotte',
                                            onPressed:
                                                () => Get.to(
                                                  () => const TicTacToeScreen(),
                                                ),
                                          ),
                                          CustomButton(label: 'Jouer à deux'),
                                        ],
                                      ),

                                      const Gap(AppSizes.spaceBtwSections),

                                      Row(
                                        children: [
                                          ResponsiveImageAsset(
                                            assetPath:
                                                SvgAssets.ticTacToeIntroMascot,
                                            width:
                                                DeviceUtils.getScreenWidth() /
                                                3,
                                          ),
                                          const Gap(AppSizes.defaultSpace),
                                          Expanded(
                                            child: Text(
                                              'Viens jouer avec moi. Gagnez et obtenez des badges !  🎖️',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.headlineSmall!.apply(
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
