import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';

/// A button with a pill-card look, following the design specs with 
/// inner highlight, hover effects and pressed state.
class PillButton extends StatefulWidget {
  /// The text to display on the button
  final String label;

  /// Optional icon to display alongside the label
  final Widget? icon;

  /// Where to render the icon relative to text
  final IconPosition iconPosition;

  /// The button style variant
  final ButtonVariant variant;

  /// The button size
  final ButtonSize size;

  /// When true: replaces icon/text with a spinner and disables onClick
  final bool isLoading;

  /// Visually dimmed & non-interactive
  final bool disabled;

  /// Callback function when the button is pressed
  final VoidCallback? onPressed;

  /// Optional width constraint (will expand to this width)
  final double? width;

  const PillButton({
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
  State<PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: (widget.disabled || widget.isLoading) ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: widget.width,
          height: _getButtonHeight(),
          transform: _isPressed 
              ? Matrix4.translationValues(0, 1, 0) 
              : Matrix4.identity(),
          decoration: BoxDecoration(
            gradient: _getGradient(),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              // Outer shadow
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 0,
                color: Colors.black.withAlpha(26),
              ),
            ],
          ),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: widget.disabled ? 0.4 : 1.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  // Gray overlay for disabled state
                  if (widget.disabled)
                    Positioned.fill(
                      child: Container(
                        color: Colors.grey.withAlpha(102),
                      ),
                    ),
                    
                  // Inner highlight effect as a container with border
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withAlpha(76),
                            spreadRadius: 1,
                            blurRadius: 0,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Button content
                  Center(
                    child: widget.isLoading
                        ? _buildLoadingIndicator()
                        : _buildButtonContent(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the loading indicator spinner
  Widget _buildLoadingIndicator() {
    return SizedBox(
      height: 16,
      width: 16,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          _getTextColor(),
        ),
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
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _getPadding(),
        ),
        child: textWidget,
      );
    }

    // Determine spacing between icon and text
    final double spacing = widget.size == ButtonSize.sm ? 6 : 8;

    // Arrange icon and text according to iconPosition
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _getPadding(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.iconPosition == IconPosition.left
            ? [
                IconTheme(
                  data: IconThemeData(
                    color: _getTextColor(),
                    size: _getIconSize(),
                  ),
                  child: widget.icon!,
                ),
                SizedBox(width: spacing),
                textWidget,
              ]
            : [
                textWidget,
                SizedBox(width: spacing),
                IconTheme(
                  data: IconThemeData(
                    color: _getTextColor(),
                    size: _getIconSize(),
                  ),
                  child: widget.icon!,
                ),
              ],
      ),
    );
  }

  /// Gets the button height based on size
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

  /// Gets the icon size based on button size
  double _getIconSize() {
    switch (widget.size) {
      case ButtonSize.sm:
        return 16;
      case ButtonSize.md:
        return 20;
      case ButtonSize.lg:
        return 24;
    }
  }

  /// Gets the horizontal padding based on button size
  double _getPadding() {
    switch (widget.size) {
      case ButtonSize.sm:
        return 16;
      case ButtonSize.md:
        return 20;
      case ButtonSize.lg:
        return 24;
    }
  }

  /// Gets the text color based on variant
  Color _getTextColor() {
    switch (widget.variant) {
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
        return Colors.white;
      case ButtonVariant.ghost:
        return AppColors.bluePrimary;
    }
  }

  /// Gets the gradient based on variant, hover and pressed states
  Gradient _getGradient() {
    if (widget.disabled) {
      return const LinearGradient(
        colors: [Colors.grey, Colors.grey],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }

    // Determine base colors based on variant
    List<Color> baseColors;
    switch (widget.variant) {
      case ButtonVariant.primary:
        baseColors = const [AppColors.bluePrimary, Color(0xFF1AB1FF)];
        break;
      case ButtonVariant.secondary:
        baseColors = const [AppColors.orangeAccent, Color(0xFFFF9800)];
        break;
      case ButtonVariant.ghost:
        return LinearGradient(
          colors: [
            Colors.transparent,
            Colors.transparent,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
    }

    // Apply brightness adjustment for hover/pressed states
    if (_isPressed) {
      // Darker by 6% when pressed
      baseColors = baseColors.map((color) => 
        HSLColor.fromColor(color)
            .withLightness((HSLColor.fromColor(color).lightness - 0.06)
            .clamp(0.0, 1.0))
            .toColor()
      ).toList();
    } else if (_isHovered) {
      // Brighter by 4% when hovered
      baseColors = baseColors.map((color) => 
        HSLColor.fromColor(color)
            .withLightness((HSLColor.fromColor(color).lightness + 0.04)
            .clamp(0.0, 1.0))
            .toColor()
      ).toList();
    }

    return LinearGradient(
      colors: baseColors,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}

// Using enums from buttons.dart