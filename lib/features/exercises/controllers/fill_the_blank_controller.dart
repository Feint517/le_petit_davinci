// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:le_petit_davinci/background_music_controller.dart';
// import 'package:le_petit_davinci/core/constants/assets_manager.dart';
// import 'package:le_petit_davinci/core/constants/colors.dart';
// import 'package:le_petit_davinci/core/constants/sizes.dart';
// import 'package:le_petit_davinci/core/utils/device_utils.dart';
// import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
// import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_exercise_model.dart';
// import 'package:le_petit_davinci/features/exercises/views/victory.dart';

// class FillTheBlankController extends GetxController {
//   FillTheBlankController(this.exercises);

//   final AudioPlayer _audioPlayer = AudioPlayer();
//   final List<FillTheBlankExercise> exercises;
//   var selectedIndex = RxnInt();
//   var currentExerciseIndex = 0.obs;

//   FillTheBlankExercise get currentExercise =>
//       exercises[currentExerciseIndex.value];

//   @override
//   void onInit() async {
//     super.onInit();
//     await BackgroundMusicController.instance.stopMusic();
//     await _audioPlayer.setAsset(AudioAssets.correctSound);
//     await _audioPlayer.setAsset(AudioAssets.errorSound);
//   }

//   void checkAnswer() async {
//     final isCorrect = selectedIndex.value == currentExercise.correctIndex;
//     final correctText =
//         currentExercise.options[currentExercise.correctIndex].optionText;

//     if (isCorrect) {
//       await _audioPlayer.setAsset(AudioAssets.correctSound);
//       await _audioPlayer.seek(Duration.zero);
//       await _audioPlayer.play();
//     } else {
//       await _audioPlayer.setAsset(AudioAssets.errorSound);
//       await _audioPlayer.seek(Duration.zero);
//       await _audioPlayer.play();
//     }
//     Get.bottomSheet(
//       Container(
//         padding: const EdgeInsets.all(AppSizes.md),
//         height: DeviceUtils.getScreenHeight() * 0.25,
//         decoration: BoxDecoration(
//           color: isCorrect ? Colors.greenAccent : Color(0xFFF9E0E0),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               spacing: AppSizes.md,
//               children: [
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: isCorrect ? Colors.green : Colors.redAccent,
//                     borderRadius: BorderRadius.circular(40),
//                   ),
//                   child: Icon(
//                     isCorrect ? Icons.check : Icons.close,
//                     color: AppColors.black,
//                   ),
//                 ),
//                 Text(
//                   isCorrect ? 'Correct!' : 'Incorrect',
//                   style: Theme.of(
//                     Get.context!,
//                   ).textTheme.headlineMedium?.copyWith(
//                     color: isCorrect ? Colors.green : Colors.redAccent,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const Gap(AppSizes.spaceBtwSections),
//             Row(
//               spacing: AppSizes.sm,
//               children: [
//                 Text(
//                   'Bonne réponse:',
//                   style: Theme.of(
//                     Get.context!,
//                   ).textTheme.bodyLarge?.copyWith(color: AppColors.black),
//                 ),
//                 Text(
//                   correctText,
//                   style: Theme.of(
//                     Get.context!,
//                   ).textTheme.bodyLarge?.copyWith(color: AppColors.accent),
//                 ),
//               ],
//             ),
//             const Gap(AppSizes.md),
//             CustomButton(
//               variant:
//                   isCorrect ? ButtonVariant.secondary : ButtonVariant.warning,
//               label: isCorrect ? 'Suivant' : 'Réessayer',
//               onPressed: () {
//                 if (isCorrect) {
//                   if (currentExerciseIndex.value < exercises.length - 1) {
//                     currentExerciseIndex.value++;
//                     selectedIndex.value = null;
//                     Get.back();
//                   } else {
//                     Get.back();
//                     Get.off(() => const VictoryScreen(starsCount: 3));
//                   }
//                 } else {
//                   selectedIndex.value = null;
//                   Get.back();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//       isDismissible: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//     );
//   }
// }
