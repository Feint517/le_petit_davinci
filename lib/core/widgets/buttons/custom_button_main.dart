import 'package:flutter/material.dart';

class CustomButtonNew extends StatelessWidget {
  final Color buttonColor;
  final Color shadowColor;
  final String label;
  final Color labelColor;
  final VoidCallback? onPressed;
  final double? width;
  final IconData? icon;
  final Color? iconColor;
  final MainAxisAlignment? mainAxisAlignment;
  const CustomButtonNew({
    super.key,
    required this.buttonColor,
    required this.shadowColor,
    required this.label,
    required this.labelColor,
    this.onPressed,
    this.width,
    this.icon,
    this.iconColor,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.35,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 2,
              blurRadius: 0,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: labelColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  textAlign: TextAlign.start,
                ),
              ),
              if (icon != null && iconColor != null) ...[
                const SizedBox(width: 8),
                Icon(icon, color: iconColor, size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
