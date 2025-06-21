import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/chips/subject_chip.dart';

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomNavBar({
    super.key,
    this.leadingText = 'Back',
    this.leadingOnPressed,
    this.activeChip = false,
    this.variant,
  });

  final bool activeChip;
  final BadgeVariant? variant;
  final String leadingText;
  final VoidCallback? leadingOnPressed;

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());

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
                color: AppColors.white,
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

          activeChip
              ? SubjectChip(
                backgroundColor: _getColor(variant ?? BadgeVariant.french),
                text: switch (variant) {
                  BadgeVariant.french => 'Français',
                  BadgeVariant.math => 'Mathématiques',
                  BadgeVariant.english => 'Anglais',
                  BadgeVariant.dailyLife => 'Vie quotidienne',
                  BadgeVariant.games => 'Jeux',
                  null => '',
                },
              )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Color _getColor(BadgeVariant badgeVariant) {
    switch (badgeVariant) {
      case BadgeVariant.french:
        return AppColors.primary;
      case BadgeVariant.math:
        return AppColors.secondary;
      case BadgeVariant.english:
        return AppColors.accent;
      case BadgeVariant.dailyLife:
        return AppColors.accent3;
      case BadgeVariant.games:
        return AppColors.secondary;
    }
  }
}
