// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/authentication/views/kids_selection_screen.dart';

class CustomButton3 extends StatefulWidget {
  const CustomButton3({
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
  State<CustomButton3> createState() => _CustomButton3State();
}

class _CustomButton3State extends State<CustomButton3>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  final GlobalKey buttonKey = GlobalKey();

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    controller.addListener(() {
      if (controller.isCompleted) {
        print('animation is completed');

        // Capture button position before navigation
        final RenderBox? renderBox =
            buttonKey.currentContext?.findRenderObject() as RenderBox?;
        Offset? buttonCenter;
        if (renderBox != null) {
          final Offset buttonPosition = renderBox.localToGlobal(Offset.zero);
          final Size buttonSize = renderBox.size;
          buttonCenter =
              buttonPosition +
              Offset(buttonSize.width / 2, buttonSize.height / 2);
          print('Button center captured: $buttonCenter');
        } else {
          print('Failed to get renderBox for button');
        }

        Navigator.of(context).push(
          MyCustomRouteTransition(
            route: const KidsSelectionScreen(),
            buttonCenter: buttonCenter,
            buttonColor: _getBackgroundColor(),
          ),
        );
        Timer(const Duration(milliseconds: 500), () => controller.reset());
      }
    });

    scaleAnimation = Tween<double>(begin: 1, end: 100).animate(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //? Determine button height based on size
    final double buttonHeight = _getButtonHeight();
    final Widget buttonContent =
        widget.isLoading ? _buildLoadingIndicator() : _buildButtonContent();
    final Color backgroundColor = _getBackgroundColor();
    final Gradient? gradient = _getGradient();

    return GestureDetector(
      onTap: () {
        controller.forward();
      },
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Container(
          key: buttonKey, // Add this line
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

class MyCustomRouteTransition extends PageRouteBuilder {
  MyCustomRouteTransition({
    required this.route,
    required this.buttonCenter,
    required this.buttonColor,
  }) : super(
         pageBuilder:
             (context, animation, secondaryAnimation) => CircleRevealTransition(
               buttonCenter: buttonCenter,
               buttonColor: buttonColor,
               child: route,
             ),
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           final tween = Tween<double>(begin: 0.0, end: 1.0).animate(
             CurvedAnimation(parent: animation, curve: Curves.easeInOut),
           );
           return FadeTransition(opacity: tween, child: child);
         },
       );

  final Widget route;
  final Offset? buttonCenter;
  final Color buttonColor;
}

class CircleRevealTransition extends StatefulWidget {
  final Widget child;
  final Offset? buttonCenter;
  final Color buttonColor;

  const CircleRevealTransition({
    super.key,
    required this.child,
    required this.buttonCenter,
    required this.buttonColor,
  });

  @override
  State<CircleRevealTransition> createState() => _CircleRevealTransitionState();
}

class _CircleRevealTransitionState extends State<CircleRevealTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _radiusAnimation;
  Offset? _center;
  double? _maxRadius;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateCircleParams();
      _controller.forward();
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _radiusAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _calculateCircleParams() {
    print('_calculateCircleParams() is called');

    if (widget.buttonCenter != null) {
      final Size screenSize = MediaQuery.of(context).size;

      setState(() {
        _center = widget.buttonCenter;
        _maxRadius = (screenSize.height + screenSize.width) * 1.2;
      });

      print('_center = $_center');
      print('_maxRadius = $_maxRadius');
    } else {
      print('buttonCenter is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_center == null || _maxRadius == null) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _radiusAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            widget.child,
            if (_radiusAnimation.value > 0)
              Positioned.fill(
                child: CustomPaint(
                  painter: _CirclePainter(
                    center: _center!,
                    radius: _maxRadius! * _radiusAnimation.value,
                    color: widget.buttonColor,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _CirclePainter extends CustomPainter {
  final Offset center;
  final double radius;
  final Color color;

  _CirclePainter({
    required this.center,
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.color != color;
  }
}
