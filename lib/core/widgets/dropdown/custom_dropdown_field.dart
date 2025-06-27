import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';

class CustomDropdownField<T> extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText,
    this.showBorder = true,
    this.borderColor = AppColors.pinkAccentDark,
    this.shadowColor = AppColors.pinkAccentDark,
    this.fillColor,
    this.dropdownColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIcon,
    this.suffixIconColor,
    this.borderRadius = 16,
  });

  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? hintText;
  final bool showBorder;
  final Color borderColor;
  final Color shadowColor;
  final Color? fillColor;
  final Color? dropdownColor;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: CustomShadowStyle.customCircleShadows(
          color: shadowColor,
          isDarker: false,
        ),
      ),
      child: Expanded(
        child: DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          hint: Text(
            hintText ?? '',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.apply(color: AppColors.darkGrey),
          ),
          icon:
              suffixIcon != null
                  ? Icon(
                    suffixIcon,
                    color: suffixIconColor ?? AppColors.pinkAccentDark,
                  )
                  : null,
          decoration: InputDecoration(
            prefixIcon:
                prefixIcon != null
                    ? Icon(
                      prefixIcon,
                      color: prefixIconColor ?? AppColors.darkGrey,
                    )
                    : null,
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.darkGrey, fontSize: 10),
            filled: true,
            fillColor: fillColor ?? AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide:
                  showBorder
                      ? BorderSide(color: borderColor, width: 1)
                      : BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide:
                  showBorder
                      ? BorderSide(color: borderColor, width: 1)
                      : BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide:
                  showBorder
                      ? BorderSide(color: borderColor, width: 1)
                      : BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide:
                  showBorder
                      ? const BorderSide(color: Colors.red, width: 2)
                      : BorderSide.none,
            ),
          ),
          dropdownColor: dropdownColor ?? AppColors.pinkAccentDark,
        ),
      ),
    );
  }
}
