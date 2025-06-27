import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';

enum TextFieldType { email, password, text }

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.fillColor,
    this.shadowColor = AppColors.pinkAccentDark,
    this.cursorColor = AppColors.pinkAccentDark,
    this.showBorder = true,
    this.borderColor = AppColors.pinkAccentDark,
    this.hintText,
    this.type = TextFieldType.text,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIcon,
    this.suffixIconColor,
    this.borderRadius = 16,
  });

  final TextEditingController controller;
  final Color? fillColor;
  final Color shadowColor;
  final Color cursorColor;
  final bool showBorder;
  final Color borderColor;
  final String? hintText;
  final TextFieldType type;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final obscureText = false.obs;
    TextInputType keyboardType;
    String defaultHint;
    switch (type) {
      case TextFieldType.email:
        keyboardType = TextInputType.emailAddress;
        defaultHint = 'Email';
        break;
      case TextFieldType.password:
        keyboardType = TextInputType.text;
        defaultHint = 'Mot de passe';
        break;
      case TextFieldType.text:
        keyboardType = TextInputType.text;
        defaultHint = 'Entrer texte';
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: fillColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: CustomShadowStyle.customCircleShadows(
          color: shadowColor,
          isDarker: false,
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText.value,
        keyboardType: keyboardType,
        cursorColor: cursorColor,
        decoration: InputDecoration(
          prefixIcon: switch (type) {
            TextFieldType.email => Icon(
              Iconsax.lock,
              color: prefixIconColor ?? AppColors.darkGrey,
            ),
            TextFieldType.password => Icon(
              Iconsax.lock,
              color: prefixIconColor ?? AppColors.darkGrey,
            ),
            TextFieldType.text =>
              (prefixIcon != null)
                  ? Icon(
                    prefixIcon,
                    color: prefixIconColor ?? AppColors.darkGrey,
                  )
                  : null,
          },
          suffixIcon: switch (type) {
            TextFieldType.email =>
              (suffixIcon != null)
                  ? Icon(
                    suffixIcon,
                    color: suffixIconColor ?? AppColors.pinkAccentDark,
                  )
                  : null,
            TextFieldType.password => Obx(
              () => IconButton(
                icon: Icon(
                  obscureText.value ? Iconsax.eye_slash : Iconsax.eye,
                  color: suffixIconColor ?? AppColors.pinkAccentDark,
                  size: 20,
                ),
                onPressed: () => obscureText.value = !obscureText.value,
              ),
            ),
            TextFieldType.text =>
              (suffixIcon != null)
                  ? Icon(
                    suffixIcon,
                    color: suffixIconColor ?? AppColors.pinkAccentDark,
                  )
                  : null,
          },
          hintText: hintText ?? defaultHint,
          hintStyle: TextStyle(color: AppColors.darkGrey),
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
                    ? BorderSide(color: borderColor, width: 2)
                    : BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:
                showBorder
                    ? BorderSide(color: Colors.red, width: 2)
                    : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
