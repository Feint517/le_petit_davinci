import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/widgets/main_panel_widget.dart';
import 'package:le_petit_davinci/features/authentication/controllers/intro_controller.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

/// Écran d'introduction avec la mascotte DaVinci
// class IntroScreen extends StatefulWidget {
//   const IntroScreen({super.key});

//   @override
//   State<IntroScreen> createState() => _IntroScreenState();
// }

// class _IntroScreenState extends State<IntroScreen> {
//   bool _showQuestionsIntro = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(ImageAssets.masscotbg),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Column(
//               children: [
//                 const Spacer(),

//                 // Panneau principal avec mascotte
//                 _showQuestionsIntro
//                     ? MainPanelWidget(
//                         speechText: "Avant de commencer ton aventure, j'ai 5 petites questions pour mieux te connaître\n\nEt pendant que tu réponds, je vais bouger et te faire coucou !",
//                         buttonText: "Je suis prêt !",
//                         onButtonPressed: () {
//                           // Navigate to first question
//                           Get.toNamed(AppRoutes.question);
//                         },
//                       )
//                     : MainPanelWidget(
//                         speechText: "Bonjour ! Moi, c'est DaVinci ! Je suis prêt à commencer cette aventure avec toi !",
//                         buttonText: "Continuer",
//                         onButtonPressed: () {
//                           setState(() {
//                             _showQuestionsIntro = true;
//                           });
//                         },
//                       ),

//                 const Spacer(),
//                 Gap(40.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //* Initialize the controller
    final controller = Get.put(IntroController());

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
                //? Use Obx to reactively update the UI
                Obx(
                  () =>
                      controller.showQuestionsIntro.value
                          ? MainPanelWidget(
                            speechText:
                                "Avant de commencer ton aventure, j'ai 5 petites questions pour mieux te connaître\n\nEt pendant que tu réponds, je vais bouger et te faire coucou !",
                            buttonText: "Je suis prêt !",
                            onButtonPressed: () {
                              Get.toNamed(AppRoutes.question);
                            },
                          )
                          : MainPanelWidget(
                            speechText:
                                "Bonjour ! Moi, c'est DaVinci ! Je suis prêt à commencer cette aventure avec toi !",
                            buttonText: "Continuer",
                            onButtonPressed: controller.showQuestions,
                          ),
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
