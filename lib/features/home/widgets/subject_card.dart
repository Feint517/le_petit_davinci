import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/features/home/models/subject_card_model.dart';
import '../../../core/constants/colors.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({super.key, required this.subject});

  final SubjectCardModel subject;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.85, //? Slightly taller than wide
      child: InkWell(
        onTap: () {
          if (subject.destination != null) {
            Get.to(() => subject.destination!, binding: subject.bindings);
          }
        },
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          decoration: BoxDecoration(
            color: subject.cardColor,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: CustomShadowStyle.customCircleShadows(
              color: subject.cardColor,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              //* Decorative bottom-right image
              Positioned(
                bottom: 0,
                right: 0,
                child: ResponsiveImageAsset(
                  assetPath: subject.imagePath,
                  width: 100.w,
                ),
              ),

              //* Content area
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top-left circular icon button
                    Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.north_east,
                        color: subject.cardColor,
                        size: 18.sp,
                      ),
                    ),

                    Gap(12.h),

                    // Subject label
                    Text(
                      subject.name,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'DynaPuff_SemiCondensed',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
