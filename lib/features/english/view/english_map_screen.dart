import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/misc/map_buttons.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/App_bar.dart';
import 'package:le_petit_davinci/core/widgets/subheader.dart';
import 'package:le_petit_davinci/features/english/controllers/english_map_controller.dart';
import 'package:le_petit_davinci/core/widgets/misc/profile_header.dart';

class EnglishMapScreen extends GetView<EnglishMapController> {
  const EnglishMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            CustomAppBar(
              chipText: 'Anglais',
              chipColor: AppColors.buttonPrimary,
            ),
            Gap(10.h),
            SubHeader(
              paragraph:
                  "Aujourd'hui, on va jouer avec les mots et écrire comme un auteur !",
              label: 'Decouvert de nouveaux mots',
              color: AppColors.purple,
              currentLevel: 1,
              maxLevel: 3,
            ),
            Gap(10.h),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    //* Assign the controller's GlobalKey to the SizedBox
                    key: controller.svgKey,
                    child: SvgPicture.asset(
                      SvgAssets.frenchMapBackground,
                      fit: BoxFit.cover,
                      width: context.width,
                      alignment: Alignment.topCenter, //? Keeps top uncropped
                    ),
                  ),

                  Obx(() {
                    //? Check if dimensions are available from the controller
                    final double? svgWidth = controller.svgRenderedWidth;
                    final double? svgHeight = controller.svgRenderedHeight;

                    if (svgWidth != null && svgHeight != null) {
                      return Stack(
                        children: [
                          //* First button at the beginning of the road
                          Positioned(
                            left: svgWidth * 0.4,
                            top:
                                svgHeight *
                                0.77, //? Adjust multiplier as needed
                            child: MapButton(
                              title: 'Dictée magique',
                              iconPath: SvgAssets.headset,
                              backgroundColor: AppColors.bluePrimary,
                              //shadowColor: AppColors.blueSecondary,
                              onTap: () {},
                            ),
                          ),

                          //* Second button at the middle of the road
                          Positioned(
                            right: svgWidth * 0.0,
                            top:
                                svgHeight *
                                0.46, //? Adjust multiplier as needed
                            child: MapButton(
                              title: 'Construction de phrases',
                              iconPath: SvgAssets.chat,
                              backgroundColor: AppColors.pinkLight,
                              //shadowColor: AppColors.pinkPrimary,
                              onTap: () {},
                            ),
                          ),

                          //* Third button at the end of the road
                          Positioned(
                            left: svgWidth * 0.4,
                            top:
                                svgHeight * 0.2, //? Adjust multiplier as needed
                            child: MapButton(
                              title: "Trouver l'erreur",
                              iconPath: SvgAssets.explore,
                              backgroundColor: AppColors.purple,
                              //shadowColor: AppColors.purpleSecondary,
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
