import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

/// Un widget qui affiche une liste d'options sélectionnables.
/// 
/// Chaque option peut contenir une icône, un texte principal, un texte secondaire
/// et un indicateur de sélection. Le widget supporte à la fois la sélection simple
/// et la sélection multiple.
class DynamicSelectionWidget extends StatelessWidget {
  /// Liste des options disponibles pour la sélection
  final List<SelectionOption> options;
  
  /// Valeur(s) actuellement sélectionnée(s)
  /// Pour la sélection simple, c'est une valeur unique
  /// Pour la sélection multiple, c'est une liste de valeurs
  final dynamic selectedValues;
  
  /// Permet la sélection de plusieurs options (false par défaut)
  final bool allowMultiSelect;
  
  /// Callback appelé lorsque la sélection change
  final Function(dynamic) onSelectionChange;
  
  /// Styles personnalisés pour les options (optionnel)
  final SelectionOptionStyle? optionStyleOverrides;

  const DynamicSelectionWidget({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onSelectionChange,
    this.allowMultiSelect = false,
    this.optionStyleOverrides,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Création de la liste d'options
        ...options.map((option) {
          final bool isSelected = _isOptionSelected(option.value);
          
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: _SelectionOptionItem(
              option: option,
              isSelected: isSelected,
              style: optionStyleOverrides,
              onTap: () => _handleOptionTap(option.value),
            ),
          );
        }).toList(),
      ],
    );
  }
  
  /// Vérifie si une option est actuellement sélectionnée
  bool _isOptionSelected(dynamic value) {
    if (allowMultiSelect) {
      // Pour la sélection multiple, vérifier si la valeur est dans la liste selectedValues
      if (selectedValues is List) {
        return selectedValues.contains(value);
      }
      return false;
    } else {
      // Pour la sélection simple, comparer avec la valeur sélectionnée
      return selectedValues == value;
    }
  }
  
  /// Gère la sélection/désélection d'une option
  void _handleOptionTap(dynamic value) {
    if (allowMultiSelect) {
      // Mode sélection multiple
      final List newSelectedValues = List.from(selectedValues is List ? selectedValues : []);
      
      if (newSelectedValues.contains(value)) {
        // Désélectionner l'option
        newSelectedValues.remove(value);
      } else {
        // Sélectionner l'option
        newSelectedValues.add(value);
      }
      
      onSelectionChange(newSelectedValues);
    } else {
      // Mode sélection simple
      if (selectedValues == value) {
        // Permettre la désélection en sélection simple (optionnel)
        onSelectionChange(null);
      } else {
        // Sélectionner la nouvelle option
        onSelectionChange(value);
      }
    }
  }
}

/// Widget pour un élément individuel de sélection
class _SelectionOptionItem extends StatelessWidget {
  final SelectionOption option;
  final bool isSelected;
  final SelectionOptionStyle? style;
  final VoidCallback onTap;

  const _SelectionOptionItem({
    required this.option,
    required this.isSelected,
    required this.onTap,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    // Appliquer les styles par défaut ou personnalisés
    final backgroundColor = style?.backgroundColor ?? AppColors.lightPink;
    final selectedIndicatorColor = style?.selectedIndicatorColor ?? AppColors.pinkPrimary;
    final textColor = style?.textColor ?? AppColors.pinkDark;
    final secondaryTextColor = style?.secondaryTextColor ?? AppColors.pinkMedium;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icône (si présente)
            if (option.iconAssetId != null) ...[
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.8),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    option.iconAssetId!,
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ],
            
            // Contenu texte
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Texte principal
                  Text(
                    option.primaryText,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      fontFamily: 'DynaPuff_SemiCondensed',
                    ),
                  ),
                  
                  // Texte secondaire (si présent)
                  if (option.secondaryText != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      option.secondaryText!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: secondaryTextColor,
                        fontFamily: 'DynaPuff_SemiCondensed',
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            // Indicateur de sélection
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? selectedIndicatorColor : Colors.transparent,
                border: Border.all(
                  color: isSelected ? selectedIndicatorColor : Colors.white,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 16.sp,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

/// Modèle de données pour une option de sélection
class SelectionOption {
  /// Identifiant unique de l'option
  final String id;
  
  /// Texte principal de l'option
  final String primaryText;
  
  /// Texte secondaire optionnel
  final String? secondaryText;
  
  /// Identifiant de l'icône dans assetManager (optionnel)
  final String? iconAssetId;
  
  /// Valeur associée à cette option
  final dynamic value;

  SelectionOption({
    required this.id,
    required this.primaryText,
    this.secondaryText,
    this.iconAssetId,
    required this.value,
  });
}

/// Classe pour personnaliser l'apparence des options
class SelectionOptionStyle {
  /// Couleur de fond de l'option
  final Color backgroundColor;
  
  /// Couleur de l'indicateur de sélection
  final Color selectedIndicatorColor;
  
  /// Couleur du texte principal
  final Color textColor;
  
  /// Couleur du texte secondaire
  final Color secondaryTextColor;

  const SelectionOptionStyle({
    this.backgroundColor = const Color(0xFFFFC0CB), // Rose clair par défaut
    this.selectedIndicatorColor = const Color(0xFFFF6B8B), // Rose plus foncé par défaut
    this.textColor = const Color(0xFF9A2551), // Rose foncé par défaut pour le texte principal
    this.secondaryTextColor = const Color(0xFFB55A7E), // Rose moyen par défaut pour le texte secondaire
  });
}
