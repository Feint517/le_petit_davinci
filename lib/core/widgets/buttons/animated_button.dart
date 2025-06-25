import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';

/// An enhanced animated button wrapper designed for kids' educational apps
/// 
/// Provides delightful animations including:
/// - Bounce animations on tap
/// - Scale animations for visual feedback
/// - Staggered entrance animations
/// - Floating animations for playful feel
class AnimatedButton extends StatefulWidget {
  final String label;
  final Widget? icon;
  final IconPosition iconPosition;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool disabled;
  final VoidCallback? onPressed;
  final double? width;
  
  /// Animation configuration
  final Duration entranceDelay;
  final bool enableFloatingAnimation;
  final bool enableBounceOnTap;
  final bool enablePulseEffect;

  const AnimatedButton({
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
    this.entranceDelay = Duration.zero,
    this.enableFloatingAnimation = true,
    this.enableBounceOnTap = true,
    this.enablePulseEffect = false,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    if (widget.enablePulseEffect) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.disabled && !widget.isLoading) {
      setState(() => _isPressed = true);
      if (widget.enableBounceOnTap) {
        _scaleController.forward();
      }
    }
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    if (widget.enableBounceOnTap) {
      _scaleController.reverse();
    }
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    if (widget.enableBounceOnTap) {
      _scaleController.reverse();
    }
  }

  void _handleTap() {
    if (!widget.disabled && !widget.isLoading) {
      // Add a small haptic feedback for kids
      widget.onPressed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget button = CustomButton(
      label: widget.label,
      icon: widget.icon,
      iconPosition: widget.iconPosition,
      variant: widget.variant,
      size: widget.size,
      isLoading: widget.isLoading,
      disabled: widget.disabled,
      onPressed: null, // We handle the tap ourselves
      width: widget.width,
    );

    // Wrap with scale animation
    if (widget.enableBounceOnTap) {
      button = AnimatedBuilder(
        animation: _scaleController,
        builder: (context, child) {
          final scale = 1.0 - (_scaleController.value * 0.05);
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: button,
      );
    }

    // Wrap with pulse effect if enabled
    if (widget.enablePulseEffect) {
      button = AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final scale = 1.0 + (_pulseController.value * 0.03);
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: button,
      );
    }

    // Add gesture detector for custom tap handling
    button = GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: _handleTap,
      child: button,
    );

    // Add entrance animations with flutter_animate
    button = button
        .animate(delay: widget.entranceDelay)
        .fadeIn(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutBack,
        )
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          duration: const Duration(milliseconds: 500),
          curve: Curves.elasticOut,
        );

    // Add floating animation if enabled
    if (widget.enableFloatingAnimation) {
      button = button
          .animate(
            onPlay: (controller) => controller.repeat(reverse: true),
          )
          .moveY(
            begin: 0,
            end: -2,
            duration: const Duration(milliseconds: 2000),
            curve: Curves.easeInOut,
          );
    }

    return button;
  }
}

/// A specialized animated button for primary actions in kids' apps
class PrimaryAnimatedButton extends StatelessWidget {
  final String label;
  final Widget? icon;
  final IconPosition iconPosition;
  final VoidCallback? onPressed;
  final double? width;
  final Duration entranceDelay;

  const PrimaryAnimatedButton({
    super.key,
    required this.label,
    this.icon,
    this.iconPosition = IconPosition.right,
    this.onPressed,
    this.width,
    this.entranceDelay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      label: label,
      icon: icon,
      iconPosition: iconPosition,
      variant: ButtonVariant.primary,
      size: ButtonSize.lg,
      onPressed: onPressed,
      width: width,
      entranceDelay: entranceDelay,
      enableFloatingAnimation: true,
      enableBounceOnTap: true,
      enablePulseEffect: false,
    );
  }
}

/// A specialized animated button for secondary actions in kids' apps
class SecondaryAnimatedButton extends StatelessWidget {
  final String label;
  final Widget? icon;
  final IconPosition iconPosition;
  final VoidCallback? onPressed;
  final double? width;
  final Duration entranceDelay;

  const SecondaryAnimatedButton({
    super.key,
    required this.label,
    this.icon,
    this.iconPosition = IconPosition.right,
    this.onPressed,
    this.width,
    this.entranceDelay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      label: label,
      icon: icon,
      iconPosition: iconPosition,
      variant: ButtonVariant.secondary,
      size: ButtonSize.lg,
      onPressed: onPressed,
      width: width,
      entranceDelay: entranceDelay,
      enableFloatingAnimation: true,
      enableBounceOnTap: true,
      enablePulseEffect: false,
    );
  }
}

/// A page transition animation wrapper for navigating between screens
class AnimatedPageTransition extends StatelessWidget {
  final Widget child;
  final Widget? nextPage;
  final VoidCallback? onTap;

  const AnimatedPageTransition({
    super.key,
    required this.child,
    this.nextPage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (nextPage == null) {
      return GestureDetector(
        onTap: onTap,
        child: child,
      );
    }

    return OpenContainer<void>(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(milliseconds: 600),
      closedColor: Colors.transparent,
      closedElevation: 0,
      openColor: Colors.transparent,
      openElevation: 0,
      closedBuilder: (context, action) => GestureDetector(
        onTap: action,
        child: child,
      ),
      openBuilder: (context, action) => nextPage!,
    );
  }
} 