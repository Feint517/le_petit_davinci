// // ignore_for_file: avoid_print

// import 'package:get/get.dart';
// import 'package:le_petit_davinci/core/constants/assets_manager.dart';
// import 'package:le_petit_davinci/features/lessons/english/listen&match/models/listen_and_match_item.dart';
// import 'package:just_audio/just_audio.dart';

// class ListenAndMatchController extends GetxController {
//   @override
//   void onClose() {
//     player.dispose();
//     super.onClose();
//   }

//   final player = AudioPlayer();
//   final items =
//       [
//         ListenAndMatchItem(
//           audioAsset: AudioAssets.a_en,
//           options: [SvgAssets.apple, SvgAssets.igloo, SvgAssets.octopus],
//           correctIndex: 0,
//         ),
//         ListenAndMatchItem(
//           audioAsset: AudioAssets.b_en,
//           options: [SvgAssets.apple, SvgAssets.igloo, SvgAssets.octopus],
//           correctIndex: 1,
//         ),
//         ListenAndMatchItem(
//           audioAsset: AudioAssets.c_en,
//           options: [SvgAssets.apple, SvgAssets.igloo, SvgAssets.octopus],
//           correctIndex: 2,
//         ),
//       ].obs;

//   var currentIndex = 0.obs;
//   var selectedOption = RxnInt();
//   var isCorrect = RxnBool();
//   var isChecked = false.obs;

//   void playAudio() async {
//     try {
//       await player.setAsset(items[currentIndex.value].audioAsset);
//       await player.play();
//     } catch (e) {
//       print('Audio playback error: $e');
//     }
//   }

//   void selectOption(int index) {
//     if (isChecked.value) return; //? Prevent changing after checking
//     selectedOption.value = index;
//     //isCorrect.value = index == items[currentIndex.value].correctIndex;
//     isChecked.value = false; // Reset check state if user changes selection
//     isCorrect.value = false;
//   }

//   void checkAnswer() {
//     if (selectedOption.value != null) {
//       isChecked.value = true;
//       isCorrect.value =
//           selectedOption.value == items[currentIndex.value].correctIndex;
//     }
//   }

//   String get feedbackMessage {
//     if (!isChecked.value) return '';
//     return isCorrect.value == true
//         ? "Bravo ! C'est correct !"
//         : "Oups ! Essaie encore !";
//   }

//   void nextQuestion() {
//     if (currentIndex.value < items.length - 1) {
//       currentIndex.value++;
//       selectedOption.value = null;
//       //isCorrect.value = null;
//       isChecked.value = false;
//       isCorrect.value = false;
//     }
//   }
// }
