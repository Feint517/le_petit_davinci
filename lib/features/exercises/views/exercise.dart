// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/core/constants/colors.dart';
// import 'package:le_petit_davinci/core/constants/sizes.dart';
// import 'package:le_petit_davinci/core/utils/device_utils.dart';
// import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
// import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
// import 'package:le_petit_davinci/features/exercises/controllers/exercises_controller.dart';
// import 'package:le_petit_davinci/features/exercises/models/story_exercise_model.dart';

// class ExerciseScreen extends GetView<ExercisesController> {
//   const ExerciseScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundLight,
//       appBar: ProfileHeader(type: ProfileHeaderType.activity),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
//         child: Column(
//           children: [
//             Expanded(
//               child: PageView.builder(
//                 controller: controller.pageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: controller.exercises.length,
//                 itemBuilder: (context, index) {
//                   final exercise = controller.exercises[index];
//                   // The model itself builds the correct view
//                   return exercise.build(context);
//                 },
//               ),
//             ),
//             // Obx(
//             //   () => CustomButton(
//             //     label: 'Check',
//             //     disabled: !controller.isAnswerReady.value,
//             //     onPressed: controller.checkAnswer,
//             //   ),
//             // ),
//             // Gap(DeviceUtils.getBottomNavigationBarHeight()),
//             Obx(() {
//               // If the current exercise is a story, it provides its own button.
//               // So, we render an empty widget here.
//               // if (controller.currentExercise is StoryExercise) {
//               //   return const SizedBox.shrink();
//               // }
//               // Otherwise, show the default "Check" button.
//               return CustomButton(
//                 label: 'Check',
//                 disabled: !controller.isAnswerReady.value,
//                 onPressed: controller.checkAnswer,
//               );
//             }),
//             // The Gap in StoryExerciseView accounts for this space,
//             // so we can remove it from here to avoid double-spacing.
//             // if (controller.currentExercise is! StoryExercise)
//             //   Gap(DeviceUtils.getBottomNavigationBarHeight()),
//           ],
//         ),
//       ),
//     );
//   }
// }
