// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:le_petit_davinci/background_music_controller.dart';
// import 'package:le_petit_davinci/core/constants/assets_manager.dart';
// import 'package:le_petit_davinci/core/constants/colors.dart';
// import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
// import 'package:le_petit_davinci/features/exercises/models/listen_and_choose_exercise_model.dart';
// import 'package:le_petit_davinci/features/exercises/views/victory.dart';

// class ListenAndChooseController extends GetxController {
//   ListenAndChooseController(this.exercises, {required this.dialect});

//   final FlutterTts flutterTts = FlutterTts();
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   final List<ListenAndChooseExercise> exercises;
//   final String dialect;
//   var selectedIndex = RxnInt();
//   var currentExerciseIndex = 0.obs;

//   var playCount = 0.obs;
//   var showHint = false.obs;

//   ListenAndChooseExercise get currentExercise =>
//       exercises[currentExerciseIndex.value];

//   @override
//   void onInit() async {
//     super.onInit();
//     await BackgroundMusicController.instance.stopMusic();
//     await _audioPlayer.setAsset(AudioAssets.correctSound);
//     await _audioPlayer.setAsset(AudioAssets.errorSound);
//   }

//   @override
//   void onClose() {
//     _audioPlayer.dispose();
//     super.onClose();
//   }

//   Future<void> playCurrentAudio() async {
//     playCount.value++;
//     if (playCount.value >= 5) {
//       showHint.value = true;
//     }
//     await flutterTts.setLanguage(dialect);
//     await flutterTts.stop();
//     await flutterTts.speak(currentExercise.label);
//   }

//   void checkAnswer() async {
//     final isCorrect = selectedIndex.value == currentExercise.correctIndex;
//     final correctLabel = currentExercise.label;

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
//         padding: const EdgeInsets.all(16),
//         height: 180,
//         decoration: BoxDecoration(
//           color: isCorrect ? Colors.greenAccent : Color(0xFFF9E0E0),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
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
//                 const SizedBox(width: 16),
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
//             const Gap(16),
//             Row(
//               children: [
//                 Text(
//                   'Bonne réponse:',
//                   style: Theme.of(
//                     Get.context!,
//                   ).textTheme.bodyLarge?.copyWith(color: AppColors.black),
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   correctLabel,
//                   style: Theme.of(
//                     Get.context!,
//                   ).textTheme.bodyLarge?.copyWith(color: AppColors.accent),
//                 ),
//               ],
//             ),
//             const Gap(16),
//             CustomButton(
//               variant:
//                   isCorrect ? ButtonVariant.secondary : ButtonVariant.warning,
//               label: isCorrect ? 'Suivant' : 'Réessayer',
//               onPressed: () {
//                 if (isCorrect) {
//                   if (currentExerciseIndex.value < exercises.length - 1) {
//                     showHint.value = false;
//                     playCount.value = 0;
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
