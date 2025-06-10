import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/widgets/buttons/profile_cards.dart';

class KidsSelection extends StatelessWidget {
  const KidsSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                SvgAssets.profileSelectionBackground,
                width: 1.sw, //? 100% of screen width
                height: (1.sw),
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      StringsManager.whatIsYourProfile,
                      style: TextStyle(
                        fontSize: 30,
                        color: AppColors.succuss,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'DynaPuff_SemiCondensed',
                      ),
                    ),
                  ),
                  Gap(40),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2, //? Adjust this ratio as needed
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: [
                      ProfileCards(
                        username: 'Alex',
                        label: 'Classe 1',
                        picture: SvgPicture.asset(
                          SvgAssets.profileSelectionBackground,
                          height: 25,
                          width: 25,
                        ),
                        backgroundColor: AppColors.bluePrimary,
                        shadowColor: AppColors.bluePrimaryDark,
                        onPressed: () {},
                      ),
                      ProfileCards(
                        username: 'Emma',
                        label: 'Classe 3',
                        picture: SvgPicture.asset(
                          SvgAssets.profileSelectionBackground,
                          height: 25,
                          width: 25,
                        ),
                        backgroundColor: AppColors.primaryOrange,
                        shadowColor: AppColors.orangeAccentDark,
                        onPressed: () {},
                      ),
                      ProfileCards(
                        username: 'José',
                        label: 'Classe 2',
                        picture: SvgPicture.asset(
                          SvgAssets.profileSelectionBackground,
                          height: 25,
                          width: 25,
                        ),
                        backgroundColor: AppColors.purpleAccent,
                        shadowColor: AppColors.purple,
                        onPressed: () {},
                      ),
                      ProfileCards(
                        username: 'Omy',
                        label: 'Classe 1',
                        picture: SvgPicture.asset(
                          SvgAssets.profileSelectionBackground,
                          height: 25,
                          width: 25,
                        ),
                        backgroundColor: AppColors.pinkAccent,
                        shadowColor: AppColors.pinkAccentDark,
                        onPressed: () {},
                      ),
                      ProfileCards(
                        label: 'Ajouter un autre enfant',
                        labelColor: AppColors.textSecondary,
                        picture: SvgPicture.asset(
                          SvgAssets.profileSelectionBackground,
                          height: 25,
                          width: 25,
                        ),
                        backgroundColor: AppColors.textWhite,
                        shadowColor: AppColors.bluePrimaryDark,
                        onPressed: () {},
                      ),
                    ],
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
