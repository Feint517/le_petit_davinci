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

class FrenchMapScreen extends StatefulWidget {
  const FrenchMapScreen({super.key});

  @override
  State<FrenchMapScreen> createState() => _FrenchMapScreenState();
}

class _FrenchMapScreenState extends State<FrenchMapScreen> {
  // Inject the controller
  // Get.put() initializes the controller if it hasn't been already.
  // Using Get.find() if you know it's already been initialized elsewhere (e.g., GetX binding).
  final FrenchMapController controller = Get.put(FrenchMapController());

  @override
  void initState() {
    super.initState();
    // Schedule the call to the controller's method after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getSvgDimensions();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              currentLevel: 1, // Current level
              maxLevel: 3, // Max level
            ),
            Gap(10),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    // Assign the controller's GlobalKey to the SizedBox
                    key: controller.svgKey,
                    child: SvgPicture.asset(
                      SvgAssets.frenchMapBackground,
                      fit: BoxFit.cover,
                      width: context.width,
                      alignment: Alignment.topCenter, // Keeps top uncropped
                    ),
                  ),

                  // Use Obx to rebuild only the Positioned widgets when dimensions change
                  Obx(() {
                    // Check if dimensions are available from the controller
                    final double? svgWidth = controller.svgRenderedWidth;
                    final double? svgHeight = controller.svgRenderedHeight;

                    if (svgWidth != null && svgHeight != null) {
                      return Stack(
                        // Wrap Positioned widgets in a Stack to return multiple children
                        children: [
                          // First button at the beginning of the road+
                          Positioned(
                            left: svgWidth * 0.4,
                            top: svgHeight * 0.8, // Adjust multiplier as needed
                            child: MapButton(
                              width: 70,
                              height: 70,
                              title: 'Le coin des leçons ',
                              iconPath: SvgAssets.lamp,
                              color: AppColors.secondary,
                              shadowColor: AppColors.orangeAccentDark,
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
                            top:
                                svgHeight * 0.63, // Adjust multiplier as needed
                            child: MapButton(
                              title: 'Magic Dictation',
                              iconPath: SvgAssets.headset,
                              color: AppColors.bluePrimary,
                              shadowColor: AppColors.blueSecondary,
                              onTap: () {},
                            ),
                          ),

                          // Second button at the middle of the road
                          Positioned(
                            right: svgWidth * 0.0,
                            top: svgHeight * 0.4, // Adjust multiplier as needed
                            child: MapButton(
                              title: 'Sentence Construction',
                              iconPath: SvgAssets.chat,
                              color: AppColors.pinkLight,
                              shadowColor: AppColors.pinkPrimary,
                              onTap: () {},
                            ),
                          ),

                          // Third button at the end of the road
                          Positioned(
                            left: svgWidth * 0.4,
                            top: svgHeight * 0.2, // Adjust multiplier as needed
                            child: MapButton(
                              title: 'Find errors',
                              iconPath: SvgAssets.explore,
                              color: AppColors.purple,
                              shadowColor: AppColors.purpleSecondary,
                              onTap: () {},
                            ),
                          ),
                        ],
                      );
                    } else {
                      // Return an empty container or a loading indicator while dimensions are null
                      return Container(
                        // child: Center(child: CircularProgressIndicator()), // Optional loading indicator
                      );
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
