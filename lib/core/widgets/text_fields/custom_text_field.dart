import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

enum TextFieldType { email, password, text }

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextFieldType type;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.type = TextFieldType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    if (widget.type != TextFieldType.password) {
      _obscureText = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextInputType keyboardType;
    String defaultHint;
    switch (widget.type) {
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
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.pinkAccentDark,
            spreadRadius: 2,
            blurRadius: 0,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: () {
            switch (widget.type) {
              case TextFieldType.password:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SvgPicture.asset(IconAssets.password)],
                );
              case TextFieldType.email:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SvgPicture.asset(IconAssets.email)],
                );
              case TextFieldType.text:
            }
          }(),
          suffixIcon:
              widget.type == TextFieldType.password
                  ? IconButton(
                    icon: Icon(
                      _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                      color: AppColors.pinkAccentDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                  : null,
          hintText: widget.hintText ?? defaultHint,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
