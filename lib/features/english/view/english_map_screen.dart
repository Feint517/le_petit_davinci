import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/widgets/misc/map_buttons.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/App_bar.dart';
import 'package:le_petit_davinci/core/widgets/subheader.dart';
import 'package:le_petit_davinci/features/english/controllers/english_map_controller.dart';
import 'package:le_petit_davinci/core/widgets/misc/profile_header.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class EnglishMapScreen extends GetView<EnglishMapController> {
  const EnglishMapScreen({super.key});

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
                    final svgWidth = controller.svgRenderedWidth;
                    final svgHeight = controller.svgRenderedHeight;

                    if (svgWidth != null && svgHeight != null) {
                      return Stack(
                        children: [
                          //* First button at the beginning of the road
                          Positioned(
                            left: svgWidth * 0.4,
                            top: svgHeight * 0.77,
                            child: MapButton(
                              title: 'Listen and Match',
                              levelStatus: LevelStatus.completed,
                              iconPath: SvgAssets.headset,
                              backgroundColor: AppColors.bluePrimary,
                              onTap:
                                  () => Get.toNamed(
                                    AppRoutes.home +
                                        AppRoutes.englishMap +
                                        AppRoutes.listenAndMatch,
                                  ),
                            ),
                          ),

                          //* Second button at the middle of the road
                          Positioned(
                            right: svgWidth * 0.05,
                            top: svgHeight * 0.46,
                            child: MapButton(
                              title: 'Word Builder',
                              levelStatus: LevelStatus.inProgress,
                              iconPath: SvgAssets.chat,
                              backgroundColor: AppColors.pinkLight,
                              onTap:
                                  () => Get.toNamed(
                                    AppRoutes.home +
                                        AppRoutes.englishMap +
                                        AppRoutes.wordBuilder,
                                  ),
                            ),
                          ),

                          //* Third button at the end of the road
                          Positioned(
                            left: svgWidth * 0.4,
                            top: svgHeight * 0.2,
                            child: MapButton(
                              title: "Find the Word",
                              levelStatus: LevelStatus.notStarted,
                              iconPath: SvgAssets.explore,
                              backgroundColor: AppColors.purple,
                              onTap:
                                  () => Get.toNamed(
                                    AppRoutes.home +
                                        AppRoutes.englishMap +
                                        AppRoutes.findTheWord,
                                  ),
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
