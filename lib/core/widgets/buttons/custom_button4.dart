import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';

class CustomButton4 extends StatelessWidget {
  const CustomButton4({
    super.key,
    required this.label,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.md,
    this.isLoading = false,
    this.disabled = false,
    this.onPressed,
    this.width,
  });

  final String label;
  final Widget? icon;
  final IconPosition iconPosition;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool disabled;
  final VoidCallback? onPressed;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: switch (size) {
        ButtonSize.sm => 40,
        ButtonSize.md => 48,
        ButtonSize.lg => 56,
      },
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: switch (variant) {
          ButtonVariant.primary => CustomShadowStyle.customCircleShadows(
            color: AppColors.primary,
          ),
          ButtonVariant.secondary => CustomShadowStyle.customCircleShadows(
            color: AppColors.secondary,
          ),
          ButtonVariant.success => CustomShadowStyle.customCircleShadows(
            color: AppColors.succuss,
          ),
          ButtonVariant.warning => CustomShadowStyle.customCircleShadows(
            color: AppColors.warning,
          ),
          ButtonVariant.ghost => CustomShadowStyle.customCircleShadows(
            color: Colors.transparent,
          ),
        },
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          splashColor: Colors.blue.withValues(alpha: 0.3),
          highlightColor: Colors.blue.withValues(alpha: 0.1),
          child: Ink(
            decoration: BoxDecoration(
              color: _getGradient() == null ? _getBackgroundColor() : null,
              gradient: _getGradient(),
              borderRadius: BorderRadius.circular(12),
              boxShadow:
                  variant != ButtonVariant.ghost
                      ? [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 2,
                          color: Colors.black.withAlpha(26),
                        ),
                      ]
                      : null,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: disabled ? 0.6 : 1.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Center(
                  child:
                      isLoading
                          //* loading indicator
                          ? SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                variant == ButtonVariant.ghost
                                    ? AppColors.primary
                                    : AppColors.white,
                              ),
                            ).animate().fadeIn(
                              duration: const Duration(milliseconds: 300),
                            ),
                          )
                          : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (iconPosition == IconPosition.left &&
                                  icon != null)
                                icon!,
                              if (iconPosition == IconPosition.left &&
                                  icon != null)
                                Gap(size == ButtonSize.sm ? 4 : 8),
                              Text(
                                label,
                                style: TextStyle(
                                  fontFamily: 'DynaPuff_SemiCondensed',
                                  fontSize: switch (size) {
                                    ButtonSize.sm => 14,
                                    ButtonSize.md => 16,
                                    ButtonSize.lg => 18,
                                  },
                                  fontWeight: FontWeight.w600,
                                  color: _getTextColor(),
                                ),
                              ),
                              if (iconPosition == IconPosition.right &&
                                  icon != null)
                                Gap(size == ButtonSize.sm ? 4 : 8),
                              if (iconPosition == IconPosition.right &&
                                  icon != null)
                                icon!,
                            ],
                          ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (disabled) {
      return AppColors.disabled;
    }
    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.primary;
      case ButtonVariant.secondary:
        return AppColors.orangeAccent;
      case ButtonVariant.success:
        return AppColors.succuss;
      case ButtonVariant.warning:
        return AppColors.warning;
      case ButtonVariant.ghost:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    if (disabled) {
      return AppColors.grey;
    }
    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.white;
      case ButtonVariant.secondary:
        return AppColors.white;
      case ButtonVariant.success:
        return AppColors.white;
      case ButtonVariant.warning:
        return AppColors.white;
      case ButtonVariant.ghost:
        return AppColors.primary;
    }
  }

  Gradient? _getGradient() {
    if (disabled || variant == ButtonVariant.ghost) {
      return null;
    }
    switch (variant) {
      case ButtonVariant.primary:
        return const LinearGradient(
          colors: [AppColors.primary, Color(0xFF1AB1FF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
      case ButtonVariant.secondary:
        return const LinearGradient(
          colors: [AppColors.orangeAccent, Color(0xFFFFAA50)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
      default:
        return null;
    }
  }
}

class AnimationController extends GetxController {
  late AnimationController _controller;
  @override
  void dispose() {}

  @override
  void onClose() {}

  @override
  void onInit() {}

  @override
  void onReady() {}
}

class MyCustomRouteTransition extends PageRouteBuilder {
  MyCustomRouteTransition({required this.route})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => route,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          //? what transition do you want to add while going to this page
          final tween = Tween(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          return SlideTransition(position: tween, child: child);
        },
      );

  final Widget route;
}
