import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/widgets/main_panel_widget.dart';

/// Écran d'accueil principal avec la mascotte DaVinci
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showQuestionsIntro = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.masscotbg),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                const Spacer(),
                
                // Panneau principal avec mascotte
                _showQuestionsIntro 
                    ? MainPanelWidget(
                        speechText: "Avant de commencer ton aventure, j'ai 5 petites questions pour mieux te connaître\n\nEt pendant que tu réponds, je vais bouger et te faire coucou !",
                        buttonText: "Je suis prêt !",
                      )
                    : MainPanelWidget(
                        speechText: "Bonjour ! Moi, c'est DaVinci ! Je suis prêt à commencer cette aventure avec toi !",
                        buttonText: "Continuer",
                        onButtonPressed: () {
                          print('Continuer button pressed!');
                          setState(() {
                            _showQuestionsIntro = true;
                          });
                        },
                      ),
                
                const Spacer(),
                Gap(40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}