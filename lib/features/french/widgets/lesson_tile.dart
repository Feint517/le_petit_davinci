import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';

class LessonTile extends StatelessWidget {
  const LessonTile({
    super.key,
    this.leadingIcon,
    this.tralingIcon,
    required this.title,
    this.trailing,
    this.onTap,
    this.leadingIconColor,
    this.trailingIconColor,
  });

  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final IconData? tralingIcon;
  final Color? trailingIconColor;
  final String title;
  final Widget? trailing;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getScreenWidth(context) * 0.9,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),

      child: ListTile(
        leading:
            leadingIcon != null
                ? Icon(leadingIcon, size: 28, color: leadingIconColor)
                : null,
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        trailing:
            tralingIcon != null
                ? Icon(
                  tralingIcon ?? Iconsax.arrow_right_1,
                  size: 28,
                  color: trailingIconColor,
                )
                : null,
        onTap: onTap,
      ),
    );
  }
}