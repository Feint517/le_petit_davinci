import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/core/widgets/misc/map_buttons.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';
import 'package:le_petit_davinci/core/widgets/subheader.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/math_map_controller.dart';
import 'package:le_petit_davinci/features/Mathematic/view/math_additions_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/math_geometry_screen.dart';
import 'package:le_petit_davinci/features/Mathematic/view/math_lessons.dart';
import 'package:le_petit_davinci/features/Mathematic/view/math_subtraction_screen.dart';
import 'package:le_petit_davinci/core/widgets/misc/profile_header.dart';

class MathematicMapScreen extends GetView<MathMapController> {
  const MathematicMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //? Call getSvgDimensions after the first frame, only if needed
    if (controller.svgRenderedWidth == null ||
        controller.svgRenderedHeight == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          controller.getSvgDimensions();
        });
      });
    }
    return Scaffold(
      body: SafeArea(
        bottom: false,
        right: false,
        left: false,
        child: Column(
          children: [
            const ProfileHeader(
              userName: 'Alex',
              userClass: 'Classe 2',
              changeAvatar: false,
            ),
            const CustomNavBar(variant: BadgeVariant.math),
            const Gap(10),
            const SubHeader(
              paragraph:
                  "Bienvenue dans le monde des chiffres ! Allons résoudre des énigmes ensemble.",
              label: 'Génie du calcul',
              color: AppColors.secondary,
              currentLevel: 1,
              maxLevel: 3,
            ),
            const Gap(10),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox.expand(
                    child: ResponsiveSvgAsset(
                      assetPath: SvgAssets.frenchMapBackground,
                      svgKey: controller.svgKey,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Obx(() {
                    //* Check if dimensions are available from the controller
                    final svgWidth = controller.svgRenderedWidth;
                    final svgHeight = controller.svgRenderedHeight;

                    if (svgWidth != null && svgHeight != null) {
                      return Stack(
                        children: [
                          //* First button at the beginning of the road
                          Positioned(
                            left: svgWidth * 0.4,
                            top: svgHeight * 0.8,
                            child: MapButton(
                              width: 70,
                              height: 70,
                              title: 'Lessons',
                              iconPath: SvgAssets.lamp,
                              backgroundColor: AppColors.secondary,
                              onTap: () {
                                Get.to(
                                  () => const MathLessons(),
                                  duration: const Duration(milliseconds: 500),
                                  transition: Transition.rightToLeft,
                                );
                              },
                            ),
                          ),

                          //* Second button
                          Positioned(
                            left: svgWidth * 0.25,
                            top: svgHeight * 0.58,
                            child: MapButton(
                              title: 'Les additions magiques',
                              iconPath: SvgAssets.headset,
                              backgroundColor: AppColors.primary,
                              onTap: () {
                                Get.to(
                                  () => const MathAdditionsScreen(),
                                  duration: const Duration(milliseconds: 500),
                                  transition: Transition.rightToLeft,
                                );
                              },
                            ),
                          ),

                          //* Third button
                          Positioned(
                            right: svgWidth * -0.1,
                            top: svgHeight * 0.4,
                            child: MapButton(
                              title: 'Les soustractions en mission',
                              iconPath: SvgAssets.chat,
                              backgroundColor: AppColors.pinkLight,
                              //shadowColor: AppColors.pinkPrimary,
                              onTap: () {
                                Get.to(
                                  () => const MathSubtractionScreen(),
                                  duration: const Duration(milliseconds: 500),
                                  transition: Transition.rightToLeft,
                                );
                              },
                            ),
                          ),

                          //* Fourth button at the end of the road
                          Positioned(
                            left: svgWidth * 0.4,
                            top: svgHeight * 0.2,
                            child: MapButton(
                              title: 'Le jeu des formes géométriques',
                              iconPath: SvgAssets.explore,
                              backgroundColor: AppColors.purple,
                              //shadowColor: AppColors.purpleSecondary,
                              onTap: () {
                                Get.to(
                                  () => const MathGeometryScreen(),
                                  duration: const Duration(milliseconds: 500),
                                  transition: Transition.rightToLeft,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
