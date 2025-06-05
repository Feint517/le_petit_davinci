import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/authentication/widgets/question_widget.dart';
import 'package:le_petit_davinci/core/widgets/square_selection_widget.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

/// Widget de panneau de questions avec grille de sélection
class QuestionGridPanelWidget extends StatefulWidget {
  /// Question à afficher
  final String questionText;

  /// Numéro de la question
  final int questionNumber;

  /// Liste des options en grille
  final List<SquareSelectionOption> gridOptions;

  /// Texte du bouton de continuer
  final String buttonText;

  /// Callback optionnel pour le bouton
  final VoidCallback? onButtonPressed;

  /// Permet la sélection multiple
  final bool multipleSelection;

  const QuestionGridPanelWidget({
    super.key,
    required this.questionText,
    required this.questionNumber,
    required this.gridOptions,
    this.buttonText = "Continuer",
    this.onButtonPressed,
    this.multipleSelection = false,
  });

  @override
  State<QuestionGridPanelWidget> createState() =>
      _QuestionGridPanelWidgetState();
}

class _QuestionGridPanelWidgetState extends State<QuestionGridPanelWidget> {
  List<String> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    // Calculate spacing
    final double questionWidgetHeight = 80.h;
    final double containerTopPosition = questionWidgetHeight * 0.5;
    final double questionOverlapIntoContainer =
        questionWidgetHeight - containerTopPosition;
    final double paddingBetweenQuestionAndContent = 40.h;
    final double containerTopPadding =
        questionOverlapIntoContainer + paddingBetweenQuestionAndContent;
    final double totalHeight = 550.h; // Slightly less height for grid layout

    return SizedBox(
      width: double.infinity,
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // White container
          Positioned(
            top: containerTopPosition,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: totalHeight - containerTopPosition,
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
                top: containerTopPadding,
                bottom: 24.w,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 8),
                    blurRadius: 24,
                    color: Colors.black.withValues(alpha: 0.1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Grid selection
                  Expanded(
                    child: SquareSelectionGrid(
                      options: widget.gridOptions,
                      onSelectionChanged: (values) {
                        setState(() {
                          selectedValues = values;
                        });
                      },
                      multipleSelection: widget.multipleSelection,
                      crossAxisCount: 2,
                    ),
                  ),

                  Gap(20.h),

                  // Bottom section with button and mascot
                  Row(
                    children: [
                      // Button on the left
                      Expanded(
                        flex: 2,
                        child: CustomButton(
                          label: widget.buttonText,
                          icon: Icon(Icons.arrow_forward, color: Colors.white),
                          iconPosition: IconPosition.right,
                          variant: ButtonVariant.secondary,
                          size: ButtonSize.lg,
                          disabled: selectedValues.isEmpty,
                          onPressed:
                              selectedValues.isNotEmpty
                                  ? (widget.onButtonPressed ??
                                      _defaultButtonAction)
                                  : null,
                        ),
                      ),

                      Gap(16.w),

                      // Mascot on the right
                      Expanded(
                        flex: 1,
                        child: SvgPicture.asset(
                          SvgAssets.bearMasscot,
                          height: 100.h,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Question widget at the top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: QuestionWidget(
              questionText: widget.questionText,
              questionNumber: widget.questionNumber,
              maxWidth: 350.w,
            ),
          ),
        ],
      ),
    );
  }

  void _defaultButtonAction() {
    print('QuestionGridPanelWidget button pressed: ${widget.buttonText}');
    print('Selected answers: $selectedValues');
    Get.toNamed(AppRoutes.userSelection);
  }
}
