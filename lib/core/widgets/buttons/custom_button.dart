import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';

/// A customizable button widget with various styles and states.
///
/// Supports different variants, sizes, icons, and loading states.
class CustomButton extends StatelessWidget {
  /// The text to display on the button
  final String label;

  /// Optional icon to display alongside the label
  final Widget? icon;

  /// Where to render the icon relative to the text
  final IconPosition iconPosition;

  /// The button style variant
  final ButtonVariant variant;

  /// The button size
  final ButtonSize size;

  /// Whether the button is in a loading state
  final bool isLoading;

  /// Whether the button is disabled
  final bool disabled;

  /// Callback function when the button is pressed
  final VoidCallback? onPressed;

  /// Optional width to make the button fill available space
  final double? width;

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
  });

  @override
  Widget build(BuildContext context) {
    // Determine button height based on size
    final double buttonHeight = _getButtonHeight();

    // Create the button content layout based on loading state
    final Widget buttonContent =
        isLoading ? _buildLoadingIndicator() : _buildButtonContent();

    // Determine the button background color based on variant
    final Color backgroundColor = _getBackgroundColor();

    // Determine the text color based on variant
    final Color textColor = _getTextColor();

    // Create gradient based on variant
    final Gradient? gradient = _getGradient();

    return Container(
      width: width,
      height: buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: switch (variant) {
          ButtonVariant.primary => CustomShadowStyle.customCircleShadows(
            color:AppColors.primary,
          ),
          ButtonVariant.secondary => CustomShadowStyle.customCircleShadows(
            color:AppColors.secondary,
          ),
          ButtonVariant.ghost => CustomShadowStyle.customCircleShadows(
            color:Colors.transparent,
          ),
        },
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap:
              (disabled || isLoading)
                  ? null
                  : () {
                    if (kDebugMode) {
                      print('CustomButton InkWell onTap triggered');
                    }
                    onPressed?.call();
                  },
          borderRadius: BorderRadius.circular(12),
          splashColor: Colors.blue.withValues(alpha: 0.3),
          highlightColor: Colors.blue.withValues(alpha: 0.1),
          child: Ink(
            decoration: BoxDecoration(
              color: gradient == null ? backgroundColor : null,
              gradient: gradient,
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
                child: Center(child: buttonContent),
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
        variant == ButtonVariant.ghost
            ? AppColors.bluePrimary
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
      label,
      style: TextStyle(
        fontFamily: 'DynaPuff_SemiCondensed',
        fontSize: _getFontSize(),
        fontWeight: FontWeight.w600,
        color: _getTextColor(),
      ),
    );

    // If there's no icon, just return the text
    if (icon == null) {
      return textWidget;
    }

    // Determine spacing between icon and text
    final double spacing = size == ButtonSize.sm ? 4 : 8;

    // Arrange icon and text according to iconPosition
    return Row(
      mainAxisSize: MainAxisSize.min,
      children:
          iconPosition == IconPosition.left
              ? [icon!, SizedBox(width: spacing), textWidget]
              : [textWidget, SizedBox(width: spacing), icon!],
    );
  }

  //* Gets the button height based on size
  double _getButtonHeight() {
    switch (size) {
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
    switch (size) {
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
    if (disabled) {
      return AppColors.disabled;
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

  /// Gets the text color based on variant
  Color _getTextColor() {
    if (disabled) {
      return AppColors.grey;
    }

    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.white;
      case ButtonVariant.secondary:
        return AppColors.white;
      case ButtonVariant.ghost:
        return AppColors.bluePrimary;
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

/// An icon button with customizable appearance
