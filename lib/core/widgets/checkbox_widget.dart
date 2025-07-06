import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';

class CheckboxWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? iconPath;
  final Widget? iconWidget;
  final bool isSelected;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final double iconSize;

  const CheckboxWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.iconPath,
    this.iconWidget,
    required this.isSelected,
    required this.onTap,
    this.backgroundColor = AppColors.checkboxPrimary,
    this.titleColor = AppColors.pinkDark,
    this.subtitleColor = AppColors.pinkMedium,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: CustomShadowStyle.customCircleShadows(
            color: backgroundColor,
          ),
        ),
        child: Row(
          children: [
            // Icône à gauche (si fournie)
            if (iconWidget != null || iconPath != null) ...[
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: Center(
                  child:
                      iconWidget ??
                      (iconPath != null
                          ? SvgPicture.asset(
                            iconPath!,
                            width: iconSize.w,
                            height: iconSize.h,
                          )
                          : Icon(
                            Icons.star,
                            size: iconSize.sp,
                            color: AppColors.orangeAccent,
                          )),
                ),
              ),
              SizedBox(width: 12.w),
            ],

            // Textes au centre
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Titre principal
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),

                  // Sous-titre (si fourni)
                  if (subtitle != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: subtitleColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Indicateur de sélection à droite
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : Colors.transparent,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child:
                  isSelected
                      ? Icon(
                        Icons.check,
                        size: 16.sp,
                        color: AppColors.pinkPrimary,
                      )
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}

class CheckboxGroup extends StatefulWidget {
  /// Liste des options à afficher
  final List<CheckboxOption> options;

  /// Fonction appelée lors d'un changement de sélection
  final Function(List<String>) onSelectionChanged;

  /// Autorise la sélection multiple
  final bool multipleSelection;

  /// Valeurs pré-sélectionnées
  final List<String>? initialSelection;

  const CheckboxGroup({
    super.key,
    required this.options,
    required this.onSelectionChanged,
    this.multipleSelection = false,
    this.initialSelection,
  });

  @override
  State<CheckboxGroup> createState() => _CheckboxGroupState();
}

class _CheckboxGroupState extends State<CheckboxGroup> {
  late List<String> selectedValues;

  @override
  void initState() {
    super.initState();
    selectedValues = widget.initialSelection ?? [];
  }

  void _onCheckboxTap(String value) {
    setState(() {
      if (selectedValues.contains(value)) {
        selectedValues.remove(value);
      } else {
        if (!widget.multipleSelection) {
          selectedValues.clear();
        }
        selectedValues.add(value);
      }
    });

    widget.onSelectionChanged(selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          widget.options.map((option) {
            return CheckboxWidget(
              title: option.title,
              subtitle: option.subtitle,
              iconPath: option.iconPath,
              iconWidget: option.iconWidget,
              isSelected: selectedValues.contains(option.value),
              onTap: () => _onCheckboxTap(option.value),
              backgroundColor: option.backgroundColor ?? AppColors.lightPink,
              titleColor: option.titleColor ?? AppColors.pinkDark,
              subtitleColor: option.subtitleColor ?? AppColors.pinkMedium,
            );
          }).toList(),
    );
  }
}

/// Modèle de données pour une option de case à cocher
class CheckboxOption {
  /// Valeur unique pour cette option
  final String value;

  /// Titre principal affiché
  final String title;

  /// Sous-titre ou description (optionnel)
  final String? subtitle;

  /// Chemin vers l'icône à afficher (optionnel)
  final String? iconPath;

  /// Widget d'icône personnalisée (prioritaire sur iconPath)
  final Widget? iconWidget;

  /// Couleur d'arrière-plan personnalisée (optionnel)
  final Color? backgroundColor;

  /// Couleur du texte principal personnalisée (optionnel)
  final Color? titleColor;

  /// Couleur du sous-titre personnalisée (optionnel)
  final Color? subtitleColor;

  CheckboxOption({
    required this.value,
    required this.title,
    this.subtitle,
    this.iconPath,
    this.iconWidget,
    this.backgroundColor,
    this.titleColor,
    this.subtitleColor,
  });
}
