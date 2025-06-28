import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';

class CustomButton2 extends StatefulWidget {
  const CustomButton2({
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
  State<CustomButton2> createState() => _CustomButton2State();
}

class _CustomButton2State extends State<CustomButton2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (!(widget.disabled || widget.isLoading)) {
      print('animation is triggered');
      _controller.forward(from: 0);
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
        widget.onPressed?.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //? Determine button height based on size
    final double buttonHeight = _getButtonHeight();

    // Create the button content layout based on loading state
    final Widget buttonContent =
        widget.isLoading ? _buildLoadingIndicator() : _buildButtonContent();

    // Determine the button background color based on variant
    final Color backgroundColor = _getBackgroundColor();

    // Determine the text color based on variant
    //final Color textColor = _getTextColor();

    // Create gradient based on variant
    final Gradient? gradient = _getGradient();

    return Animate(
      controller: _controller,
      effects: [
        SlideEffect(
          begin: const Offset(0, 0),
          end: const Offset(0, -0.3),
          curve: Curves.linear,
          duration: const Duration(milliseconds: 100),
        ),
      ],
      child: Container(
        width: widget.width,
        height: buttonHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: switch (widget.variant) {
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
            onTap: _handleTap,
            borderRadius: BorderRadius.circular(12),
            splashColor: Colors.blue.withValues(alpha: 0.3),
            highlightColor: Colors.blue.withValues(alpha: 0.1),
            child: Ink(
              decoration: BoxDecoration(
                color: gradient == null ? backgroundColor : null,
                gradient: gradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow:
                    widget.variant != ButtonVariant.ghost
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
                opacity: widget.disabled ? 0.6 : 1.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Center(child: buttonContent),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Builds the loading indicator with the appropriate color based on the button variant
  Widget _buildLoadingIndicator() {
    final Color indicatorColor =
        widget.variant == ButtonVariant.ghost
            ? AppColors.primary
            : AppColors.white;

    return SizedBox(
      height: 16,
      width: 16,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
      ).animate().fadeIn(duration: const Duration(milliseconds: 300)),
    );
  }

  /// Builds the button content with icon and label based on iconPosition
  Widget _buildButtonContent() {
    // Create text widget with appropriate style
    final textWidget = Text(
      widget.label,
      style: TextStyle(
        fontFamily: 'DynaPuff_SemiCondensed',
        fontSize: _getFontSize(),
        fontWeight: FontWeight.w600,
        color: _getTextColor(),
      ),
    );

    // If there's no icon, just return the text
    if (widget.icon == null) {
      return textWidget;
    }

    // Determine spacing between icon and text
    final double spacing = widget.size == ButtonSize.sm ? 4 : 8;

    // Arrange icon and text according to iconPosition
    return Row(
      mainAxisSize: MainAxisSize.min,
      children:
          widget.iconPosition == IconPosition.left
              ? [widget.icon!, SizedBox(width: spacing), textWidget]
              : [textWidget, SizedBox(width: spacing), widget.icon!],
    );
  }

  //* Gets the button height based on size
  double _getButtonHeight() {
    switch (widget.size) {
      case ButtonSize.sm:
        return 40;
      case ButtonSize.md:
        return 48;
      case ButtonSize.lg:
        return 56;
    }
  }

  /// Gets the font size based on button size
  double _getFontSize() {
    switch (widget.size) {
      case ButtonSize.sm:
        return 14;
      case ButtonSize.md:
        return 16;
      case ButtonSize.lg:
        return 18;
    }
  }

  /// Gets the background color based on variant
  Color _getBackgroundColor() {
    if (widget.disabled) {
      return AppColors.disabled;
    }

    switch (widget.variant) {
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

  /// Gets the text color based on variant
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

  /// Gets the gradient based on variant
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
