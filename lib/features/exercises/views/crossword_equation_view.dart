// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/core/constants/colors.dart';
// import 'package:le_petit_davinci/core/constants/sizes.dart';
// import 'package:le_petit_davinci/features/exercises/models/crowssword_equation_model.dart';
// import 'package:le_petit_davinci/features/exercises/widgets/numpad.dart';

// class MathEquationCrosswordView extends StatelessWidget {
//   const MathEquationCrosswordView({super.key, required this.exercise});

//   final MathEquationCrosswordExercise exercise;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           exercise.instruction,
//           style: Theme.of(context).textTheme.headlineSmall,
//           textAlign: TextAlign.center,
//         ),
//         const Spacer(),
//         // The Crossword Grid
//         AspectRatio(
//           aspectRatio: 1.0, // Square grid
//           child: GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: exercise.gridSize * exercise.gridSize,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: exercise.gridSize,
//             ),
//             itemBuilder: (context, index) {
//               final row = index ~/ exercise.gridSize;
//               final col = index % exercise.gridSize;

//               // Only show cells that are part of an equation
//               if (!exercise.isEquationCell(row, col)) {
//                 // return Container(color: Colors.transparent);
//                 return SizedBox.shrink();
//               }

//               return Obx(() {
//                 final isBlank = exercise.isBlankCell(row, col);
//                 final isSelected =
//                     exercise.selectedCell.value[0] == row &&
//                     exercise.selectedCell.value[1] == col;

//                 return GestureDetector(
//                   onTap: () {
//                     if (isBlank) exercise.selectCell(row, col);
//                   },
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 200),
//                     decoration: BoxDecoration(
//                       color: isBlank ? AppColors.light : Colors.transparent,
//                       border: Border.all(
//                         color:
//                             isSelected
//                                 ? AppColors.primary
//                                 : isBlank
//                                 ? AppColors.grey
//                                 : Colors.transparent,
//                         width: isSelected ? 2.5 : 1.5,
//                       ),
//                     ),
//                     alignment: Alignment.center,
//                     child: Text(
//                       exercise.getCellContent(row, col),
//                       style: Theme.of(
//                         context,
//                       ).textTheme.headlineMedium?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: isBlank ? AppColors.primary : AppColors.black,
//                       ),
//                     ),
//                   ),
//                 );
//               });
//             },
//           ),
//         ),
//         const Spacer(),
//         // The Numpad for input
//         Numpad(
//           onNumberPressed: exercise.enterDigit,
//           onBackspacePressed: exercise.backspace,
//         ),
//         const Gap(AppSizes.md),
//       ],
//     );
//   }
// }
