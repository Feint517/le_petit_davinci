import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class SubHeader extends StatelessWidget {
  final String paragraph;
  final String label;
  final Color color;
  final int currentLevel;
  final int maxLevel;

  const SubHeader({
    super.key,
    required this.paragraph,
    required this.label,
    required this.color,
    required this.currentLevel,
    required this.maxLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Text(paragraph, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Gap(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: color,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(SvgAssets.learnHat, height: 20.h, width: 20.w),
                    Gap(5.w),
                    Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Text('Niveau $currentLevel/$maxLevel', 
                style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}