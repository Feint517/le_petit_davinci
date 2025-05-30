import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/features/authentication/widgets/header_vector.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        top: false,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                SvgAssets.errorBackground,
                width: DeviceUtils.getScreenWidth(context),
                fit: BoxFit.fitWidth,
              ),
            ),
            HeaderVector(color: HeaderVectorColor.green),
          ],
        ),
      ),
    );
  }
}
