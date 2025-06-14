import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/chips/subject_chip.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.chipText,
    required this.chipColor,
    this.leadingText = 'Back',
    this.leadingOnPressed,
  });

  final String chipText;
  final Color chipColor;
  final String leadingText;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: leadingOnPressed ?? () => Get.back(),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColors.backgroundLight,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 10,
                  ),
                  Text(leadingText, style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ),

          SubjectChip(backgroundColor: chipColor, text: chipText),
        ],
      ),
    );
  }
}
