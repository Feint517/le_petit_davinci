import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button_main.dart';
import 'package:le_petit_davinci/core/widgets/subheader.dart';
import 'package:le_petit_davinci/core/widgets/top_navigation.dart';

class FrenchLessons extends StatefulWidget {
  const FrenchLessons({super.key});

  @override
  State<FrenchLessons> createState() => _FrenchLessonsState();
}

class _FrenchLessonsState extends State<FrenchLessons> {
  // Inject the controller
  // Get.put() initializes the controller if it hasn't been already.
  // Using Get.find() if you know it's already been initialized elsewhere (e.g., GetX bi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluePrimary,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            spacing: 15,
            children: [
              TopNavigation(
                text: 'Français',
                buttonColor: AppColors.bluePrimaryDark,
              ),
              SubHeader(
                paragraph: "Matériel d'apprentissage",
                color: AppColors.secondary,
              ),
              Container(
                child: Column(
                  spacing: 15,
                  children: [
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '1- Le déterminant',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '2- Comment identifier un déterminant ?',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '3- Le pronom',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '4- Comment identifier un adjectif ?',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '5- Le verbe',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '6- Le groupe du nom',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '7- Comment identifier un nom ?',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '8- Le nom commun et le nom propre',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '9- Survoler le texte',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '10- Activer mes connaissances',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '11- Résumer le texte',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '12- Identifier les informations importantes',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '13- Identifier mon intention de lecture',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '14- Me faire une image',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '15- Tenir compte de la ponctuation',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                    CustomButtonNew(
                      buttonColor: AppColors.white,
                      shadowColor: AppColors.white,
                      label: '16- Relire',
                      labelColor: AppColors.textPrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        // Navigate to lessons screen
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                  ],
                ),
              ),
              Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
