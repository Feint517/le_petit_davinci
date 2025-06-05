import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/checkbox_widget.dart';
import 'package:le_petit_davinci/features/authentication/widgets/question_widget.dart';
import 'package:le_petit_davinci/features/authentication/controllers/questions_controller.dart';
import 'package:get/get.dart';

// class QuestionScreenOld extends StatelessWidget {
//   const QuestionScreenOld({super.key});

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
//                 Gap(20.h),

//                 // Question panel widget
//                 QuestionPanelWidget(
//                   questionText:
//                       "Combien de temps veux-tu apprendre chaque jour ?",
//                   questionNumber: 1,
//                   options: [
//                     CheckboxOption(
//                       value: '5',
//                       title: '5 minutes',
//                       subtitle: 'Juste pour m\'amuser',
//                       iconWidget: Icon(
//                         Icons.access_time,
//                         color: AppColors.orangeAccent,
//                         size: 24.sp,
//                       ),
//                     ),
//                     CheckboxOption(
//                       value: '10',
//                       title: '10 minutes',
//                       subtitle: 'Un petit défi',
//                       iconWidget: Icon(
//                         Icons.timer,
//                         color: AppColors.orangeAccent,
//                         size: 24.sp,
//                       ),
//                     ),
//                     CheckboxOption(
//                       value: '15',
//                       title: '15 minutes ou +',
//                       subtitle: 'Je veux apprendre beaucoup',
//                       iconWidget: Icon(
//                         Icons.all_inclusive,
//                         color: AppColors.orangeAccent,
//                         size: 24.sp,
//                       ),
//                     ),
//                   ],
//                   buttonText: "Continuer",
//                   onButtonPressed: () {
//                     // Navigate to second question
//                     Get.toNamed(AppRoutes.questionTwo);
//                   },
//                 ),

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

// class QuestionScreen2 extends StatelessWidget {
//   const QuestionScreen2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(QuestionsController());

//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/masscotbg.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Obx(() {
//               final question =
//                   controller.questions[controller.currentIndex.value];
//               return Column(
//                 children: [
//                   SizedBox(height: 20.h),
//                   Text(
//                     "Question ${controller.currentIndex.value + 1}/${controller.questions.length}",
//                     style: TextStyle(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//                   Text(
//                     question.questionText,
//                     style: TextStyle(
//                       fontSize: 22.sp,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//                   ...question.options.map(
//                     (option) => ListTile(
//                       title: Text(option.title),
//                       subtitle: Text(option.subtitle),
//                       leading: option.iconWidget,
//                       trailing: Radio<String>(
//                         value: option.value,
//                         groupValue:
//                             controller.answers[controller.currentIndex.value],
//                         onChanged: (val) {
//                           controller.answers[controller.currentIndex.value] =
//                               val!;
//                         },
//                       ),
//                       onTap: () {
//                         controller.answers[controller.currentIndex.value] =
//                             option.value;
//                       },
//                     ),
//                   ),
//                   Spacer(),
//                   ElevatedButton(
//                     onPressed: () {
//                       final answer =
//                           controller.answers[controller.currentIndex.value];
//                       if (answer != null) {
//                         controller.nextQuestion(answer);
//                       } else {
//                         Get.snackbar(
//                           "Attention",
//                           "Veuillez sélectionner une réponse.",
//                         );
//                       }
//                     },
//                     child: Text(
//                       controller.currentIndex.value <
//                               controller.questions.length - 1
//                           ? "Continuer"
//                           : "Terminer",
//                     ),
//                   ),
//                   SizedBox(height: 40.h),
//                 ],
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuestionsController());
    return Scaffold(
      body: Stack(
        children: [
          //* Fullscreen background image
          SizedBox.expand(
            child: Image.asset(
              ImageAssets.questionBackground,
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Obx(() {
                final question =
                    controller.questions[controller.currentIndex.value];
                final selected =
                    controller.answers[controller.currentIndex.value];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gap(20.h),
                    Container(
                      width: 0.9.sw,
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 16,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          QuestionWidget(
                            questionNumber: controller.currentIndex.value + 1,
                            questionText: question.questionText,
                          ),
                          Gap(20.h),

                          ...List.generate(
                            question.options.length,
                            (i) => CheckboxWidget(
                              title: question.options[i].title,
                              subtitle: question.options[i].subtitle,
                              //icon: question.options[i].iconWidget,
                              isSelected: selected == question.options[i].value,
                              onTap: () {
                                controller.answers[controller
                                        .currentIndex
                                        .value] =
                                    question.options[i].value;
                              },
                            ),
                          ),
                          Gap(20.h),
                          CustomButton(
                            variant: ButtonVariant.secondary,
                            label:
                                controller.currentIndex.value <
                                        controller.questions.length - 1
                                    ? "Continuer"
                                    : "Terminer",
                            onPressed: () {
                              controller.checkIfQuestionAnswered();
                            },
                            size: ButtonSize.lg,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          Positioned(
            bottom: 60.h,
            right: 20.w,
            child: SvgPicture.asset(
              SvgAssets.bearMasscot, // Replace with your mascot asset
              width: 200.w, // Adjust size as needed
              height: 250.h,
            ),
          ),
        ],
      ),
    );
  }
}
