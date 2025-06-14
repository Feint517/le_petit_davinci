import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/misc/map_buttons.dart';
import 'package:le_petit_davinci/core/widgets/misc/profile_header.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/App_bar.dart';
import 'package:le_petit_davinci/core/widgets/subheader.dart';
import 'package:le_petit_davinci/features/french/controller/french_map_controller.dart';
import 'package:le_petit_davinci/features/french/view/introduction_lessons.dart';

class FrenchMapScreen extends GetView<FrenchMapController> {
  const FrenchMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //? Reset dimensions if both are null (first entry)
    if (controller.svgRenderedWidth == null &&
        controller.svgRenderedHeight == null) {
      controller.resetSvgDimensions();
    }

    //? Call getSvgDimensions after the first frame, only if needed
    if (controller.svgRenderedWidth == null ||
        controller.svgRenderedHeight == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.getSvgDimensions();
      });
    }
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ProfileHeader(
              userName: 'Alex',
              userClass: 'Classe 2',
              changeAvatar: false,
            ),
            CustomAppBar(chipText: 'French', chipColor: AppColors.bluePrimary),
            Gap(10),
            SubHeader(
              paragraph:
                  "Aujourd'hui, on va jouer avec les mots et écrire comme un auteur !",
              label: 'Decouvert de nouveaux mots',
              color: AppColors.bluePrimary,
              currentLevel: 1,
              maxLevel: 3,
            ),
            Gap(10),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    key: controller.svgKey,
                    child: SvgPicture.asset(
                      SvgAssets.frenchMapBackground,
                      fit: BoxFit.cover,
                      width: context.width,
                      alignment: Alignment.topCenter, //? Keeps top uncropped
                    ),
                  ),

                  Obx(() {
                    final double? svgWidth = controller.svgRenderedWidth;
                    final double? svgHeight = controller.svgRenderedHeight;

                    if (svgWidth != null && svgHeight != null) {
                      return Stack(
                        children: [
                          //* First button at the beginning of the road+
                          Positioned(
                            left: svgWidth * 0.4,
                            top: svgHeight * 0.8,
                            child: MapButton(
                              width: 70,
                              height: 70,
                              title: 'Le coin des leçons ',
                              iconPath: SvgAssets.lamp,
                              backgroundColor: AppColors.secondary,
                              onTap: () {
                                Get.to(
                                  () => const IntroductionFrenchLessons(),
                                  duration: const Duration(milliseconds: 500),
                                  transition: Transition.rightToLeft,
                                );
                              },
                            ),
                          ),
                          Positioned(
                            left: svgWidth * 0.25,
                            top: svgHeight * 0.63,
                            child: MapButton(
                              title: 'Magic Dictation',
                              iconPath: SvgAssets.headset,
                              backgroundColor: AppColors.bluePrimary,
                              onTap: () {},
                            ),
                          ),

                          //* Second button at the middle of the road
                          Positioned(
                            right: svgWidth * 0.0,
                            top: svgHeight * 0.4,
                            child: MapButton(
                              title: 'Sentence Construction',
                              iconPath: SvgAssets.chat,
                              backgroundColor: AppColors.pinkLight,
                              onTap: () {},
                            ),
                          ),

                          //* Third button at the end of the road
                          Positioned(
                            left: svgWidth * 0.4,
                            top: svgHeight * 0.2,
                            child: MapButton(
                              title: 'Find errors',
                              iconPath: SvgAssets.explore,
                              backgroundColor: AppColors.purple,
                              onTap: () {},
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
