// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/core/constants/colors.dart';
// import 'package:le_petit_davinci/core/constants/sizes.dart';
// import 'package:le_petit_davinci/core/styles/shadows.dart';
// import 'package:le_petit_davinci/core/utils/device_utils.dart';
// import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
// import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
// import 'package:le_petit_davinci/features/exercises/controllers/fill_the_blank_controller.dart';
// import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_exercise_model.dart';
// import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_option_model.dart';
// import 'package:le_petit_davinci/features/exercises/widgets/progress_bar.dart';

// class FillTheBlankScreen extends StatelessWidget {
//   const FillTheBlankScreen({super.key, required this.exercises});

//   final List<FillTheBlankExercise> exercises;

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<FillTheBlankController>(
//       init: FillTheBlankController(exercises),
//       builder: (controller) {
//         return Scaffold(
//           backgroundColor: AppColors.backgroundLight,
//           appBar: ProfileHeader(type: ProfileHeaderType.compact),
//           body: Padding(
//             padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
//             child: Obx(() {
//               final exercise = controller.currentExercise;
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ProgressBar(
//                     progress:
//                         (controller.currentExerciseIndex.value + 1) /
//                         controller.exercises.length,
//                     backgroundColor: AppColors.grey,
//                     progressColor: AppColors.accent,
//                   ),
//                   const Gap(AppSizes.spaceBtwSections),
//                   Text(
//                     'Fill in the blanks',
//                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                       color: AppColors.black,
//                     ),
//                   ),
//                   const Gap(AppSizes.spaceBtwSections),
//                   //* The question
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Container(
//                         width: 60,
//                         margin: const EdgeInsets.symmetric(horizontal: 4),
//                         decoration: BoxDecoration(
//                           border: Border(
//                             bottom: BorderSide(
//                               color: AppColors.accent,
//                               width: 3,
//                             ),
//                           ),
//                         ),
//                         child: Center(
//                           child: Obx(() {
//                             final selected = controller.selectedIndex.value;
//                             return Text(
//                               selected != null
//                                   ? exercise.options[selected].optionText
//                                   : '',
//                               style: Theme.of(
//                                 context,
//                               ).textTheme.bodyMedium?.copyWith(
//                                 color: AppColors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             );
//                           }),
//                         ),
//                       ),
//                       Text(
//                         ' ${exercise.questionSuffix}',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: AppColors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Gap(140),
//                   ChoicesSection(options: exercise.options),
//                   const Spacer(),
//                   CustomButton(
//                     label: 'Check',
//                     disabled: controller.selectedIndex.value == null,
//                     onPressed: controller.checkAnswer,
//                   ),
//                   Gap(DeviceUtils.getBottomNavigationBarHeight()),
//                 ],
//               );
//             }),
//           ),
//         );
//       },
//     );
//   }
// }

// class ChoicesSection extends GetView<FillTheBlankController> {
//   const ChoicesSection({super.key, required this.options});

//   final List<FillTheBlankOption> options;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Column(
//         spacing: AppSizes.spaceBtwItems,
//         children: List.generate(options.length, (index) {
//           return ChoiceButton(
//             choiceText: options[index].optionText,
//             isSelected: controller.selectedIndex.value == index,
//             onTap: () => controller.selectedIndex.value = index,
//           );
//         }),
//       ),
//     );
//   }
// }

// class ChoiceButton extends StatelessWidget {
//   const ChoiceButton({
//     super.key,
//     required this.choiceText,
//     this.isSelected = false,
//     this.onTap,
//   });

//   final String choiceText;
//   final bool isSelected;
//   final VoidCallback? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         width: DeviceUtils.getScreenWidth(),
//         height: 45,
//         decoration: BoxDecoration(
//           color: isSelected ? AppColors.accent : AppColors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: CustomShadowStyle.customCircleShadows(
//             color: isSelected ? AppColors.accent : AppColors.white,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             choiceText,
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//               color: AppColors.black,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
