// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/core/constants/colors.dart';
// import 'package:le_petit_davinci/core/constants/sizes.dart';
// import 'package:le_petit_davinci/core/styles/shadows.dart';
// import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
// import 'package:le_petit_davinci/core/widgets/layouts/grid_layout.dart';
// import 'package:le_petit_davinci/features/exercises/models/listen_and_choose_exercise_model.dart';
// import 'package:le_petit_davinci/features/exercises/widgets/play_audio_button.dart';
// import 'package:le_petit_davinci/features/exercises/controllers/exercises_controller.dart';

// class ListenAndChooseView extends GetView<ExercisesController> {
//   const ListenAndChooseView({super.key, required this.exercise});

//   final ListenAndChooseExercise exercise;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Stack(
//           alignment: Alignment.center,
//           children: [
//             CustomGridLayout(
//               itemCount: exercise.imageAssets.length,
//               spacing: AppSizes.gridViewSpacing * 2,
//               itemBuilder: (context, index) {
//                 return Obx(
//                   () => GestureDetector(
//                     onTap: () => exercise.selectOption(index),
//                     child: AnimatedContainer(
//                       duration: const Duration(milliseconds: 200),
//                       padding: EdgeInsets.all(AppSizes.sm),
//                       decoration: BoxDecoration(
//                         color:
//                             exercise.selectedIndex.value == index
//                                 ? Color(0xFFe1f4ff)
//                                 : AppColors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: CustomShadowStyle.customCircleShadows(
//                           color:
//                               exercise.selectedIndex.value == index
//                                   ? AppColors.primary
//                                   : AppColors.grey,
//                         ),
//                         border: Border.all(
//                           color:
//                               exercise.selectedIndex.value == index
//                                   ? AppColors.primary
//                                   : AppColors.grey,
//                         ),
//                       ),
//                       alignment: Alignment.center,
//                       child: SizedBox(
//                         width: 120,
//                         height: 120,
//                         child: ResponsiveImageAsset(
//                           assetPath: exercise.imageAssets[index],
//                           width: 120,
//                           height: 120,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             PlayAudioButton(
//               buttonSize: PlayAudioButtonSize.big,
//               onPressed: controller.playCurrentAudio,
//             ),
//           ],
//         ),
//         const Gap(AppSizes.spaceBtwSections),
//         Obx(() {
//           // Cast the exercise to access its specific properties
//           final listenExercise = exercise;
//           return AnimatedOpacity(
//             // Read the state directly from the exercise model
//             opacity: listenExercise.showHint.value ? 1.0 : 0.0,
//             duration: const Duration(milliseconds: 400),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   exercise.label,
//                   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                     color: AppColors.accent,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           );
//         }),
//       ],
//     );
//   }
// }
