import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart'; 
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/subheader.dart';
import 'package:le_petit_davinci/core/widgets/top_navigation.dart';
import 'package:le_petit_davinci/features/french/controller/french_map_controller.dart';
import 'package:le_petit_davinci/features/home/widgets/profile_header.dart';

class EnglishMapScreen extends StatefulWidget {
  const EnglishMapScreen({super.key});

  @override
  State<EnglishMapScreen> createState() => _EnglishMapScreenState();
}

class _EnglishMapScreenState extends State<EnglishMapScreen> {
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
            TopNavigation(text: 'Anglais', buttonColor: AppColors.buttonPrimary),
            Gap(10.h),
            SubHeader(
              paragraph: "Aujourd'hui, on va jouer avec les mots et écrire comme un auteur !",
              label: 'Decouvert de nouveaux mots',
             color:  AppColors.purple, 
             currentLevel:  1, // Current level
              maxLevel: 3, // Max level
            ),
            Gap(10.h),
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
                      alignment: Alignment.topCenter, // Keeps top uncropped
                    ),
                  ),

                  // Use Obx to rebuild only the Positioned widgets when dimensions change
                  Obx(() {
                    // Check if dimensions are available from the controller
                    final double? svgWidth = controller.svgRenderedWidth;
                    final double? svgHeight = controller.svgRenderedHeight;

                    if (svgWidth != null && svgHeight != null) {
                      return Stack( // Wrap Positioned widgets in a Stack to return multiple children
                        children: [
                          // First button at the beginning of the road
                          Positioned(
                            left: svgWidth * 0.4,
                            top: svgHeight * 0.77, // Adjust multiplier as needed
                            child: _buildMapButton('Dictée magique',
                              SvgAssets.headset,
                              AppColors.bluePrimary,
                              AppColors.blueSecondary,
                            ),
                          ),

                          // Second button at the middle of the road
                          Positioned(
                            right: svgWidth * 0.0,
                            top: svgHeight * 0.46, // Adjust multiplier as needed
                            child: _buildMapButton('Construction de phrases',
                              SvgAssets.chat,
                              AppColors.pinkLight,
                              AppColors.pinkPrimary,
                            ),
                          ),

                          // Third button at the end of the road
                          Positioned(
                            left: svgWidth * 0.4,
                            top: svgHeight * 0.2, // Adjust multiplier as needed
                            child: _buildMapButton("Trouver l'erreur",
                              SvgAssets.explore,
                              AppColors.purple,
                              AppColors.purpleSecondary,
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

  Widget _buildMapButton(String title,String iconPath, Color color, Color shadowColor,) {
    return Column(spacing: 5,
      children: [
        Container(
          width: 70.w,
          height: 70.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                spreadRadius: 2,
                blurRadius: 0,
                offset: const Offset(5, 5),
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              height: 40.h,
              width: 40.w,
            ),
          ),
        ),
      Text(title, style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14) ),
      ],
    );
  }

   

   
}