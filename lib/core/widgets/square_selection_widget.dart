import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

/// Widget de sélection carré pour une grille d'options
class SquareSelectionWidget extends StatelessWidget {
  /// Titre de l'option
  final String title;

  /// Icône à afficher
  final IconData icon;

  /// Couleur de l'icône
  final Color iconColor;

  /// État de sélection
  final bool isSelected;

  /// Callback quand l'utilisateur tape
  final VoidCallback onTap;

  /// Couleur de fond quand sélectionné
  final Color selectedColor;

  const SquareSelectionWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
    this.selectedColor = AppColors.lightPink,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? iconColor : AppColors.borderPrimary,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 4,
              color: Colors.black.withValues(alpha: 0.1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icône
            Icon(
              icon,
              size: 36.sp,
              color: isSelected ? iconColor : iconColor.withValues(alpha: 0.7),
            ),

            SizedBox(height: 8.h),

            // Titre
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? iconColor : AppColors.textPrimary,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget de grille de sélection
class SquareSelectionGrid extends StatefulWidget {
  /// Liste des options
  final List<SquareSelectionOption> options;

  /// Callback quand la sélection change
  final Function(List<String>) onSelectionChanged;

  /// Permet la sélection multiple
  final bool multipleSelection;

  /// Nombre de colonnes
  final int crossAxisCount;

  /// Valeurs présélectionnées
  final List<String>? initialSelection;

  const SquareSelectionGrid({
    super.key,
    required this.options,
    required this.onSelectionChanged,
    this.multipleSelection = false,
    this.crossAxisCount = 2,
    this.initialSelection,
  });

  @override
  State<SquareSelectionGrid> createState() => _SquareSelectionGridState();
}

class _SquareSelectionGridState extends State<SquareSelectionGrid> {
  late List<String> selectedValues;

  @override
  void initState() {
    super.initState();
    selectedValues = widget.initialSelection ?? [];
  }

  void _onOptionTap(String value) {
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
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemCount: widget.options.length,
      itemBuilder: (context, index) {
        final option = widget.options[index];
        return SquareSelectionWidget(
          title: option.title,
          icon: option.icon,
          iconColor: option.iconColor,
          isSelected: selectedValues.contains(option.value),
          onTap: () => _onOptionTap(option.value),
          selectedColor:
              option.selectedColor ??
              AppColors.lightPink.withValues(alpha: 0.3),
        );
      },
    );
  }
}

/// Modèle pour une option de sélection carrée
class SquareSelectionOption {
  final String value;
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color? selectedColor;

  SquareSelectionOption({
    required this.value,
    required this.title,
    required this.icon,
    required this.iconColor,
    this.selectedColor,
  });
}
