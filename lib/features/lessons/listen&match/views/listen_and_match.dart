// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/core/constants/sizes.dart';
// import 'package:le_petit_davinci/features/english/controllers/listen_and_match_controller.dart';
// import 'package:le_petit_davinci/features/lessons/widget/choice_option.dart';
// import 'package:le_petit_davinci/core/widgets/audio/sound_play_button.dart';

// class ListenAndMatch extends GetView<ListenAndMatchController> {
//   const ListenAndMatch({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final item = controller.items[controller.currentIndex.value];
//       return Column(
//         children: [
//           const Text(
//             "Sélectionnez l'image qui correspond au son",
//             style: TextStyle(color: Colors.white),
//           ),
//           const Gap(AppSizes.spaceBtwItems),
//           SoundPlayButton(onTap: controller.playAudio),
//           const Gap(AppSizes.spaceBtwSections * 2),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ...List.generate(item.options.length, (index) {
//                 return ChoiceOption(
//                   image: item.options[index],
//                   onTap: () {
//                     controller.selectOption(index);
//                   },
//                 );
//               }),
//             ],
//           ),
//         ],
//       );
//     });
//   }
// }
