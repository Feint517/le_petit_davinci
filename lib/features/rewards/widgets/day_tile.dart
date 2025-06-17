import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';

class DayTile extends StatelessWidget {
  const DayTile({
    super.key,
    required this.label,
    required this.backgroundColor,
    this.starsColor = Colors.blueAccent,
    required this.starsCount,
    this.isActive = true,
  });

  final String label;
  final Color backgroundColor;
  final Color starsColor;
  final int starsCount;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
      decoration: BoxDecoration(
        color: isActive ? backgroundColor : AppColors.disabled,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.headlineMedium!.apply(
                color: isActive ? AppColors.white : AppColors.darkGrey,
              ),
            ),
            isActive
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(
                      starsCount,
                      (index) => Icon(Iconsax.star1, color: starsColor),
                    ),
                  ],
                )
                : Text(
                  'Obtenez des étoiles plus tard',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppColors.darkGrey,
                    fontSize: 10,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
