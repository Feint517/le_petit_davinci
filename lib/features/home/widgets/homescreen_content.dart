import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/widgets/misc/mascot_widget.dart';
import 'mission_card.dart';

class HomeScreenContent extends StatelessWidget {
  final String mascotMessage;
  final String missionDescription;
  final VoidCallback? onAcceptMission;

  const HomeScreenContent({
    super.key,
    required this.mascotMessage,
    required this.missionDescription,
    this.onAcceptMission,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.h, //? Fixed height to prevent unbounded constraints
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          //* Background homeScreen image
          SvgPicture.asset(
            SvgAssets.homeScreenImage,
            width: double.infinity,
            height: 400.h,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),

          //* Mascot widget positioned in center-right, slightly top
          Align(
            alignment: Alignment(1.0, -0.8),
            child: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: SizedBox(
                width: 280.w,
                child: MascotWidget(
                  speechText: mascotMessage,
                  mascotSize: 140.h,
                  textSize: 18.sp,
                  bubblePosition: BubblePosition.center,
                ),
              ),
            ),
          ),

          //* Mission Card positioned slightly below center
          Align(
            alignment: Alignment(0.0, 1.1),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: MissionCard(
                missionTitle: 'Mission du jour',
                missionDescription: missionDescription,
                onAcceptMission: onAcceptMission,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
