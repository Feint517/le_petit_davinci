import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button_main.dart';
import 'package:le_petit_davinci/core/widgets/misc/profile_header.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';

class VieQuotidienneScreen extends StatelessWidget {
  const VieQuotidienneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenPrimary,
      body: SafeArea(
        bottom: false,
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  ProfileHeader(
                    userName: 'Alex',
                    userClass: 'Classe 2',
                    changeAvatar: false,
                  ),
                  ContentVieQuotidienne(),
                  SvgPicture.asset(SvgAssets.schoolTools),
                ],
              ),
              Positioned(
                bottom: -70,
                child: SvgPicture.asset(
                  SvgAssets.bottom_backgroundvq,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
              ),

              Positioned(
                bottom: 20,
                left: 30,
                child: CustomButtonNew(
                  buttonColor: AppColors.secondary,
                  shadowColor: AppColors.orangeAccentDark,
                  label: 'Précédent',
                  labelColor: AppColors.white,
                  onPressed: () {},
                ),
              ),
              Positioned(
                bottom: 20,
                right: 30,
                child: CustomButtonNew(
                  buttonColor: AppColors.primaryBlue,
                  shadowColor: AppColors.bluePrimaryDark,
                  label: 'Suivant',
                  labelColor: AppColors.white,
                  onPressed: () {
                    // Handle the next button action
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContentVieQuotidienne extends StatelessWidget {
  const ContentVieQuotidienne({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomNavBar(
                        chipText: 'Vie quotidienne',
                        chipColor: AppColors.secondary,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Tu vas à l'école. Allez, préparez vos valises maintenant !",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Glisser les bons objets dans un sac.',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      SvgPicture.asset(SvgAssets.vie_quotidienne_background2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: SvgPicture.asset(SvgAssets.bearvq),
        ),
      ],
    );
  }
}
