import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';

enum AnimationType { bounceUp, scaleDown }

class CustomButton extends StatefulWidget {
  const CustomButton({
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
    this.borderRadius,
    this.animationType = AnimationType.bounceUp,
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
  final double? borderRadius;
  final AnimationType animationType;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );

    switch (widget.animationType) {
      case AnimationType.bounceUp:
        _animation = Tween<double>(
          begin: 0.0,
          end: 4.0,
        ).animate(CurvedAnimation(parent: controller, curve: Curves.bounceIn));
      case AnimationType.scaleDown:
        _animation = Tween<double>(
          begin: 1,
          end: 0.9,
        ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: switch (widget.animationType) {
            AnimationType.bounceUp =>
              Matrix4.identity()..translate(Vector3(0, _animation.value, 0)),
            AnimationType.scaleDown =>
              Matrix4.identity()..scale(_animation.value),
          },
          child: Container(
            width: widget.width,
            height: switch (widget.size) {
              ButtonSize.sm => 40,
              ButtonSize.md => 48,
              ButtonSize.lg => 56,
            },
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              boxShadow: switch (widget.variant) {
                ButtonVariant.primary => CustomShadowStyle.customCircleShadows(
                  color: AppColors.primary,
                ),
                ButtonVariant.secondary =>
                  CustomShadowStyle.customCircleShadows(
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
                onTap: () {
                  if (!(widget.disabled || widget.isLoading)) {
                    controller.forward(from: 0);
                    controller.addStatusListener((status) {
                      if (status == AnimationStatus.completed) {
                        controller.reverse();
                      }
                    });
                    widget.onPressed?.call();
                  }
                },
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
                splashColor: Colors.blue.withValues(alpha: 0.3),
                highlightColor: Colors.blue.withValues(alpha: 0.1),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: _getGradient(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: widget.disabled ? 0.6 : 1.0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Center(
                        child:
                            widget.isLoading
                                //* loading indicator
                                ? SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      widget.variant == ButtonVariant.ghost
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
                                    if (widget.iconPosition ==
                                            IconPosition.left &&
                                        widget.icon != null)
                                      widget.icon!,
                                    if (widget.iconPosition ==
                                            IconPosition.left &&
                                        widget.icon != null)
                                      Gap(widget.size == ButtonSize.sm ? 4 : 8),
                                    const Gap(AppSizes.sm),
                                    Text(
                                      widget.label,
                                      style: TextStyle(
                                        fontSize: switch (widget.size) {
                                          ButtonSize.sm => 14,
                                          ButtonSize.md => 16,
                                          ButtonSize.lg => 18,
                                        },
                                        fontWeight: FontWeight.w600,
                                        color: _getTextColor(),
                                      ),
                                    ),
                                    const Gap(AppSizes.sm),
                                    if (widget.iconPosition ==
                                            IconPosition.right &&
                                        widget.icon != null)
                                      Gap(widget.size == ButtonSize.sm ? 4 : 8),
                                    if (widget.iconPosition ==
                                            IconPosition.right &&
                                        widget.icon != null)
                                      widget.icon!,
                                  ],
                                ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getTextColor() {
    if (widget.disabled) {
      return AppColors.grey;
    }
    switch (widget.variant) {
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
    if (widget.disabled || widget.variant == ButtonVariant.ghost) {
      return null;
    }
    switch (widget.variant) {
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
