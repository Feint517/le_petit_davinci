import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/widgets/misc/profile_card.dart';

class KidsSelectionScreen extends StatelessWidget {
  const KidsSelectionScreen({super.key});

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
                  const Gap(40),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: [
                      ProfileCard(
                        isExpanded: true,
                        name: 'Alex',
                        subInfo: 'Classe 1',
                        image: SvgAssets.profileSelectionBackground,
                        backgroundColor: AppColors.primary,
                      ),
                      ProfileCard(
                        isExpanded: true,
                        name: 'Emma',
                        subInfo: 'Classe 3',
                        image: SvgAssets.profileSelectionBackground,
                        backgroundColor: AppColors.primaryOrange,
                      ),
                      ProfileCard(
                        isExpanded: true,
                        name: 'José',
                        subInfo: 'Classe 2',
                        image: SvgAssets.profileSelectionBackground,
                        backgroundColor: AppColors.purpleAccent,
                      ),
                      ProfileCard(
                        isExpanded: true,
                        name: 'Omy',
                        subInfo: 'Classe 1',
                        image: SvgAssets.profileSelectionBackground,
                        backgroundColor: AppColors.pinkAccent,
                      ),
                      // ProfileCard(
                      //   name: '',
                      //   label: 'Ajouter un autre enfant',
                      //   labelColor: AppColors.textSecondary,
                      //   picture: SvgAssets.profileSelectionBackground,
                      //   backgroundColor: AppColors.white,
                      //   onPressed: () {},
                      // ),
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
