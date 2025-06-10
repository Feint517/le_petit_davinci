import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button_main.dart';
import 'package:le_petit_davinci/core/widgets/misc/profile_header.dart';
import 'package:le_petit_davinci/core/widgets/subheader.dart';
import 'package:le_petit_davinci/core/widgets/top_navigation.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  // Inject the controller
  // Get.put() initializes the controller if it hasn't been already.
  // Using Get.find() if you know it's already been initialized elsewhere (e.g., GetX bi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluePrimary,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                SvgAssets.games_background,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                ProfileHeader(
                  userName: 'Alex',
                  userClass: 'Classe 2',
                  changeAvatar: false,
                ),
                TopNavigation(text: 'Jeux', buttonColor: AppColors.secondary),
                Gap(10),
                SubHeader(
                  paragraph:
                      "C'est l'heure de s'amuser !\n Choisis ton jeu préféré !",
                  color: AppColors.secondary,
                ),
                Gap(10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: GamesCards(
                          cardColor: AppColors.primary,
                          label: '5 Victoires',
                          title: 'Tic Tac Toe',
                          shadowColor: AppColors.primaryShadow,
                          assetPath: SvgAssets.tictactoe,
                          onTap: () {},
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: GamesCards(
                          cardColor: AppColors.pinkLight,
                          label: '2 Victoires',
                          title: 'Échecs simplifiés',
                          shadowColor: AppColors.pinkAccentDark,
                          assetPath: SvgAssets.chess,
                          onTap: () {},
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: GamesCards(
                          cardColor: AppColors.greenPrimary,
                          label: '0 Victoires',
                          title: 'Suites logiques',
                          shadowColor: AppColors.succuss,
                          assetPath: SvgAssets.biscuit,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GamesCards extends StatelessWidget {
  final Color cardColor;
  final String label;
  final String title;
  final String assetPath;
  final Color shadowColor;
  final VoidCallback? onTap;
  const GamesCards({
    super.key,
    required this.cardColor,
    required this.label,
    required this.title,
    required this.shadowColor,
    this.onTap,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: shadowColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                spreadRadius: 2,
                blurRadius: 0,
                offset: const Offset(5, 5), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              SvgPicture.asset(assetPath),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.background,
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                ),
              ),
              CustomButtonNew(
                buttonColor: AppColors.secondary,
                shadowColor: AppColors.orangeAccentDark,
                label: 'Jouer',
                labelColor: AppColors.background,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
