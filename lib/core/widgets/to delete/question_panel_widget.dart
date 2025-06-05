// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/core/constants/assets_manager.dart';
// import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
// import 'package:le_petit_davinci/core/widgets/checkbox_widget.dart';
// import 'package:le_petit_davinci/features/authentication/widgets/question_widget.dart';
// import 'package:le_petit_davinci/routes/app_routes.dart';

// /// Widget de panneau de questions similaire au MainPanelWidget
// class QuestionPanelWidget extends StatefulWidget {
//   /// Question à afficher
//   final String questionText;

//   /// Numéro de la question
//   final int questionNumber;

//   /// Liste des options de réponse
//   final List<CheckboxOption> options;

//   /// Texte du bouton de continuer
//   final String buttonText;

//   /// Callback optionnel pour le bouton (si null, navigue vers userSelection)
//   final VoidCallback? onButtonPressed;

//   /// Permet la sélection multiple (false par défaut)
//   final bool multipleSelection;

//   const QuestionPanelWidget({
//     super.key,
//     required this.questionText,
//     required this.questionNumber,
//     required this.options,
//     this.buttonText = "Continuer",
//     this.onButtonPressed,
//     this.multipleSelection = false,
//   });

//   @override
//   State<QuestionPanelWidget> createState() => _QuestionPanelWidgetState();
// }

// class _QuestionPanelWidgetState extends State<QuestionPanelWidget> {
//   List<String> selectedValues = [];

//   @override
//   Widget build(BuildContext context) {
//     // Calculate automatic spacing similar to MainPanelWidget
//     final double questionWidgetHeight = 80.h;
//     final double containerTopPosition =
//         questionWidgetHeight * 0.5; // Increased to push container down
//     final double questionOverlapIntoContainer =
//         questionWidgetHeight - containerTopPosition;
//     final double paddingBetweenQuestionAndContent =
//         60.h; // Increased padding for more space
//     final double containerTopPadding =
//         questionOverlapIntoContainer + paddingBetweenQuestionAndContent;
//     final double totalHeight =
//         680.h; // Increased height to fit all checkboxes without scrolling

//     return SizedBox(
//       width: double.infinity,
//       height: totalHeight,
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.center,
//         children: [
//           // White container positioned lower to leave space for question
//           Positioned(
//             top: containerTopPosition,
//             left: 0,
//             right: 0,
//             child: Container(
//               width: double.infinity,
//               height: totalHeight - containerTopPosition,
//               padding: EdgeInsets.only(
//                 left: 24.w,
//                 right: 24.w,
//                 top: containerTopPadding,
//                 bottom: 24.w,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20.r),
//                 boxShadow: [
//                   BoxShadow(
//                     offset: const Offset(0, 8),
//                     blurRadius: 24,
//                     color: Colors.black.withValues(alpha: 0.1),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   // Checkbox options
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: CheckboxGroup(
//                         options: widget.options,
//                         onSelectionChanged: (values) {
//                           setState(() {
//                             selectedValues = values;
//                           });
//                         },
//                         multipleSelection: widget.multipleSelection,
//                       ),
//                     ),
//                   ),

//                   Gap(40.h),

//                   // Bottom section with mascot and button
//                   Row(
//                     children: [
//                       // Button on the left
//                       Expanded(
//                         flex: 2,
//                         child: CustomButton(
//                           label: widget.buttonText,
//                           icon: Icon(Icons.arrow_forward, color: Colors.white),
//                           iconPosition: IconPosition.right,
//                           variant: ButtonVariant.secondary,
//                           size: ButtonSize.lg,
//                           disabled: selectedValues.isEmpty,
//                           onPressed:
//                               selectedValues.isNotEmpty
//                                   ? (widget.onButtonPressed ??
//                                       _defaultButtonAction)
//                                   : null,
//                         ),
//                       ),

//                       Gap(16.w),

//                       // Mascot on the right
//                       Expanded(
//                         flex: 1,
//                         child: SvgPicture.asset(
//                           SvgAssets.bearMasscot,
//                           height: 120.h,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Question widget positioned at the top, outside white box
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: QuestionWidget(
//               questionText: widget.questionText,
//               questionNumber: widget.questionNumber,
//               maxWidth: 350.w,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Action par défaut du bouton (navigation vers user selection)
//   void _defaultButtonAction() {
//     print('QuestionPanelWidget button pressed: ${widget.buttonText}');
//     print('Selected answer: $selectedValues');
//     Get.toNamed(AppRoutes.userSelection);
//   }
// }
