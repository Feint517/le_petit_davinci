import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons.dart';

class CustomIconButton extends StatelessWidget {
  /// The icon to display
  final Widget icon;
  
  /// The button variant that determines its color scheme
  final ButtonVariant variant;
  
  /// The size of the button
  final ButtonSize size;
  
  /// Whether the button is in a loading state
  final bool isLoading;
  
  /// Whether the button is disabled
  final bool disabled;
  
  /// Callback function when the button is pressed
  final VoidCallback? onPressed;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.md,
    this.isLoading = false,
    this.disabled = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonSize = _getButtonSize();
    final Color backgroundColor = _getBackgroundColor();
    final Gradient? gradient = _getGradient();

    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (disabled || isLoading) ? null : onPressed,
          borderRadius: BorderRadius.circular(buttonSize / 2),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: gradient == null ? backgroundColor : null,
              gradient: gradient,
              shape: BoxShape.circle,
              boxShadow: variant != ButtonVariant.ghost 
                ? [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                      color: Colors.black.withAlpha(26),
                    )
                  ]
                : null,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: disabled ? 0.6 : 1.0,
              child: Center(
                child: isLoading
                    ? SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            variant == ButtonVariant.ghost
                                ? AppColors.bluePrimary
                                : AppColors.white,
                          ),
                        ),
                      )
                    : IconTheme(
                        data: IconThemeData(
                          color: variant == ButtonVariant.ghost
                              ? AppColors.bluePrimary
                              : AppColors.white,
                          size: _getIconSize(),
                        ),
                        child: icon,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Gets the button size based on size enum
  double _getButtonSize() {
    switch (size) {
      case ButtonSize.sm:
        return 36;
      case ButtonSize.md:
        return 48;
      case ButtonSize.lg:
        return 56;
    }
  }

  /// Gets the icon size based on button size
  double _getIconSize() {
    switch (size) {
      case ButtonSize.sm:
        return 16;
      case ButtonSize.md:
        return 20;
      case ButtonSize.lg:
        return 24;
    }
  }

  /// Gets the background color based on variant
  Color _getBackgroundColor() {
    if (disabled) {
      return AppColors.buttonDisabled;
    }

    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.bluePrimary;
      case ButtonVariant.secondary:
        return AppColors.orangeAccent;
      case ButtonVariant.ghost:
        return Colors.transparent;
    }
  }

  /// Gets the gradient based on variant
  Gradient? _getGradient() {
    if (disabled || variant == ButtonVariant.ghost) {
      return null;
    }

    switch (variant) {
      case ButtonVariant.primary:
        return const LinearGradient(
          colors: [AppColors.bluePrimary, Color(0xFF1AB1FF)],
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