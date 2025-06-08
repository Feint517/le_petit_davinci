import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/misc/map_buttons.dart';
import 'package:le_petit_davinci/core/widgets/subheader.dart';
import 'package:le_petit_davinci/core/widgets/top_navigation.dart';
import 'package:le_petit_davinci/features/french/controller/french_map_controller.dart';
import 'package:le_petit_davinci/core/widgets/misc/profile_header.dart';

class MathematicMapScreen extends StatefulWidget {
  const MathematicMapScreen({super.key});

  @override
  State<MathematicMapScreen> createState() => _MathematicMapScreenState();
}

class _MathematicMapScreenState extends State<MathematicMapScreen> {
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
            TopNavigation(
              text: 'Mathematiques',
              buttonColor: AppColors.secondary,
            ),
            Gap(10),
            SubHeader(
              paragraph:
                  "Bienvenue dans le monde des chiffres ! Allons résoudre des énigmes ensemble.",
              label: 'Génie du calcul',
              color: AppColors.secondary,
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
                      width: context.width,
                      fit: BoxFit.cover,
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
                          // First button at the beginning of the road
                          Positioned(
                            left: svgWidth * 0.4,
                            top:
                                svgHeight * 0.77, // Adjust multiplier as needed
                            child: MapButton(
                              title: 'Dictée magique',
                              iconPath: SvgAssets.headset,
                              color: AppColors.bluePrimary,
                              shadowColor: AppColors.blueSecondary,
                              onTap: () {},
                            ),
                          ),

                          // Second button at the middle of the road
                          Positioned(
                            right: svgWidth * 0.0,
                            top:
                                svgHeight * 0.46, // Adjust multiplier as needed
                            child: MapButton(
                              title: 'resoudre des énigmes',
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
                              title: "Trouver l'erreur",
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
