// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/core/constants/assets_manager.dart';
// import 'package:le_petit_davinci/core/constants/colors.dart';
// import 'package:le_petit_davinci/core/constants/sizes.dart';
// import 'package:le_petit_davinci/core/styles/shadows.dart';
// import 'package:le_petit_davinci/core/utils/device_utils.dart';
// import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
// import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
// import 'package:le_petit_davinci/core/widgets/layouts/grid_layout.dart';
// import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
// import 'package:le_petit_davinci/features/exercises/controllers/unified_exercise_controller.dart';
// import 'package:le_petit_davinci/features/exercises/models/unified_exercise_model.dart';
// import 'package:le_petit_davinci/features/exercises/widgets/play_audio_button.dart';
// import 'package:le_petit_davinci/features/exercises/widgets/progress_bar.dart';

// class UnifiedExerciseScreen extends StatelessWidget {
//   const UnifiedExerciseScreen({
//     super.key,
//     required this.exercises,
//     required this.dialect,
//   });

//   final List<UnifiedExercise> exercises;
//   final String dialect;

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<UnifiedExerciseController>(
//       init: UnifiedExerciseController(exercises, dialect: dialect),
//       builder: (controller) {
//         return Scaffold(
//           backgroundColor: AppColors.backgroundLight,
//           appBar: ProfileHeader(type: ProfileHeaderType.compact),
//           body: Padding(
//             padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
//             child: Obx(() {
//               final exercise = controller.currentExercise;
//               return AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 400),
//                 transitionBuilder:
//                     (child, animation) =>
//                         FadeTransition(opacity: animation, child: child),
//                 child: Column(
//                   key: ValueKey(controller.currentExerciseIndex.value),
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ProgressBar(
//                       progress:
//                           (controller.currentExerciseIndex.value + 1) /
//                           controller.exercises.length,
//                       backgroundColor: AppColors.grey,
//                       progressColor: AppColors.accent,
//                     ),
//                     const Gap(AppSizes.spaceBtwSections),
//                     Text(
//                       _getExerciseTitle(exercise.type),
//                       style: Theme.of(context).textTheme.headlineMedium
//                           ?.copyWith(color: AppColors.black),
//                     ),
//                     const Gap(AppSizes.spaceBtwSections),
//                     Expanded(
//                       child: _buildExerciseContent(
//                         context,
//                         controller,
//                         exercise,
//                       ),
//                     ),
//                     CustomButton(
//                       label: 'Check',
//                       disabled: !controller.canCheckAnswer,
//                       onPressed: controller.checkAnswer,
//                     ),
//                     Gap(DeviceUtils.getBottomNavigationBarHeight()),
//                   ],
//                 ),
//               );
//             }),
//           ),
//         );
//       },
//     );
//   }

//   String _getExerciseTitle(ExerciseType type) {
//     switch (type) {
//       case ExerciseType.fillTheBlank:
//         return 'Fill in the blanks';
//       case ExerciseType.listenAndChoose:
//         return 'Listen and Choose';
//       case ExerciseType.reorderWords:
//         return 'Reorder Words';
//     }
//   }

//   Widget _buildExerciseContent(
//     BuildContext context,
//     UnifiedExerciseController controller,
//     UnifiedExercise exercise,
//   ) {
//     switch (exercise.type) {
//       case ExerciseType.fillTheBlank:
//         return _buildFillTheBlankContent(
//           context,
//           controller,
//           exercise.fillTheBlankExercise!,
//         );
//       case ExerciseType.listenAndChoose:
//         return _buildListenAndChooseContent(
//           context,
//           controller,
//           exercise.listenAndChooseExercise!,
//         );
//       case ExerciseType.reorderWords:
//         return _buildReorderWordsContent(
//           context,
//           controller,
//           exercise.reorderWordsExercise!,
//         );
//     }
//   }

//   Widget _buildFillTheBlankContent(
//     BuildContext context,
//     UnifiedExerciseController controller,
//     dynamic exercise,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // The question
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Container(
//               width: 60,
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               decoration: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(color: AppColors.accent, width: 3),
//                 ),
//               ),
//               child: Center(
//                 child: Obx(() {
//                   final selected = controller.selectedFillBlankIndex.value;
//                   return Text(
//                     selected != null
//                         ? exercise.options[selected].optionText
//                         : '',
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: AppColors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   );
//                 }),
//               ),
//             ),
//             Text(
//               ' ${exercise.questionSuffix}',
//               style: Theme.of(
//                 context,
//               ).textTheme.bodyMedium?.copyWith(color: AppColors.black),
//             ),
//           ],
//         ),
//         const Gap(140),
//         // Choices
//         Expanded(
//           child: Column(
//             spacing: AppSizes.spaceBtwItems,
//             children: List.generate(exercise.options.length, (index) {
//               return Obx(
//                 () => GestureDetector(
//                   onTap: () => controller.selectedFillBlankIndex.value = index,
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 200),
//                     width: DeviceUtils.getScreenWidth(),
//                     height: 45,
//                     decoration: BoxDecoration(
//                       color:
//                           controller.selectedFillBlankIndex.value == index
//                               ? AppColors.accent
//                               : AppColors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: CustomShadowStyle.customCircleShadows(
//                         color:
//                             controller.selectedFillBlankIndex.value == index
//                                 ? AppColors.accent
//                                 : AppColors.white,
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         exercise.options[index].optionText,
//                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                           color: AppColors.black,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildListenAndChooseContent(
//     BuildContext context,
//     UnifiedExerciseController controller,
//     dynamic exercise,
//   ) {
//     return Column(
//       children: [
//         Stack(
//           alignment: Alignment.center,
//           children: [
//             CustomGridLayout2(
//               itemCount: exercise.imageAssets.length,
//               spacing: AppSizes.gridViewSpacing * 2,
//               itemBuilder: (context, index) {
//                 return Obx(
//                   () => GestureDetector(
//                     onTap:
//                         () =>
//                             controller.selectedListenChooseIndex.value = index,
//                     child: AnimatedContainer(
//                       duration: const Duration(milliseconds: 200),
//                       padding: EdgeInsets.all(AppSizes.sm),
//                       decoration: BoxDecoration(
//                         color:
//                             controller.selectedListenChooseIndex.value == index
//                                 ? Color(0xFFe1f4ff)
//                                 : AppColors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: CustomShadowStyle.customCircleShadows(
//                           color:
//                               controller.selectedListenChooseIndex.value ==
//                                       index
//                                   ? AppColors.primary
//                                   : AppColors.grey,
//                         ),
//                         border: Border.all(
//                           color:
//                               controller.selectedListenChooseIndex.value ==
//                                       index
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
//         Obx(
//           () => AnimatedOpacity(
//             opacity: controller.showHint.value ? 1.0 : 0.0,
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
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildReorderWordsContent(
//     BuildContext context,
//     UnifiedExerciseController controller,
//     dynamic exercise,
//   ) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const ResponsiveImageAsset(
//               assetPath: SvgAssets.bearMasscot,
//               width: 200,
//               height: 200,
//             ),
//             const Gap(AppSizes.md),
//             PlayAudioButton(
//               onPressed:
//                   () async => await controller.speakSentence(
//                     exercise.correctOrder
//                         .map((i) => exercise.words[i])
//                         .join(' '),
//                   ),
//             ),
//           ],
//         ),
//         const Gap(AppSizes.spaceBtwSections * 2),
//         // Selected words row
//         Obx(
//           () => Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(controller.selectedOrder.length, (i) {
//               final wordIdx = controller.selectedOrder[i];
//               return GestureDetector(
//                 onTap: () => controller.selectedOrder.remove(wordIdx),
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 8,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppColors.accent.withValues(alpha: 0.15),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: AppColors.accent, width: 2),
//                   ),
//                   child: Text(
//                     exercise.words[wordIdx],
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: AppColors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//         const Gap(AppSizes.spaceBtwSections * 2),
//         // Word options
//         Obx(
//           () => Wrap(
//             spacing: AppSizes.md,
//             runSpacing: AppSizes.md,
//             alignment: WrapAlignment.center,
//             children: List.generate(exercise.words.length, (index) {
//               final isSelected = controller.selectedOrder.contains(index);
//               return GestureDetector(
//                 onTap:
//                     isSelected
//                         ? null
//                         : () => controller.selectedOrder.add(index),
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: AppSizes.sm,
//                     vertical: AppSizes.sm,
//                   ),
//                   decoration: BoxDecoration(
//                     color: isSelected ? AppColors.grey : AppColors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(width: 2),
//                     boxShadow: CustomShadowStyle.customCircleShadows(
//                       color: AppColors.grey,
//                       offsetY: 1,
//                     ),
//                   ),
//                   child: Text(
//                     exercise.words[index],
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ],
//     );
//   }
// }
