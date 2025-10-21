import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/leaderboard/models/player_model.dart';

class LeaderboardItem extends StatelessWidget {
  final PlayerModel player;
  final int rank;
  final bool isCurrentUser;

  const LeaderboardItem({
    super.key,
    required this.player,
    required this.rank,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color:
            isCurrentUser
                ? AppColors.primary.withOpacity(0.1)
                : AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border:
            isCurrentUser
                ? Border.all(color: AppColors.primary, width: 2.w)
                : Border.all(color: AppColors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: _getRankColor(),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Gap(16.w),

          // Avatar
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Center(
              child: Text(player.avatar, style: TextStyle(fontSize: 24.sp)),
            ),
          ),

          Gap(16.w),

          // Player info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color:
                        isCurrentUser
                            ? AppColors.primary
                            : AppColors.textPrimary,
                  ),
                ),
                Gap(4.h),
                Text(
                  'Level ${player.level}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Stars
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 18.sp),
                  Gap(4.w),
                  Text(
                    player.totalStars.toString(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Gap(4.h),
              Text(
                'stars',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getRankColor() {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey[400]!;
      case 3:
        return Colors.orange[300]!;
      default:
        return AppColors.primary;
    }
  }
}
