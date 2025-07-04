import 'dart:async';

import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/rewards/views/rewards.dart';

class ScaleTransitionOverlay extends StatefulWidget {
  final Widget child;
  final Widget targetPage;
  final Duration duration;
  final double scaleFactor;

  const ScaleTransitionOverlay({
    required this.child,
    required this.targetPage,
    this.duration = const Duration(milliseconds: 500),
    this.scaleFactor = 30.0,
    super.key,
  });

  @override
  State<ScaleTransitionOverlay> createState() => _ScaleTransitionOverlayState();
}

class _ScaleTransitionOverlayState extends State<ScaleTransitionOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  bool _showOverlay = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleFactor,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('Animation is triggerd');
        Timer(const Duration(milliseconds: 500), () {});
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder:
                (_, __, ___) => ReverseScalePage(
                  duration: widget.duration,
                  scaleFactor: widget.scaleFactor,
                  child: widget.targetPage,
                ),
            transitionDuration: Duration.zero,
          ),
        );
        Timer(const Duration(milliseconds: 500), () => _controller.reset());
        //_controller.reset();
        setState(() => _showOverlay = false);
      }
    });
  }

  void _onTap() {
    setState(() => _showOverlay = true);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(onTap: _onTap, child: widget.child),
        if (_showOverlay)
          AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return Center(
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: widget.child,
                ),
              );
            },
          ),
      ],
    );
  }
}

class ReverseScalePage extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double scaleFactor;

  const ReverseScalePage({
    required this.child,
    required this.duration,
    required this.scaleFactor,
    super.key,
  });

  @override
  State<ReverseScalePage> createState() => _ReverseScalePageState();
}

class _ReverseScalePageState extends State<ReverseScalePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _animationDone = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _scaleAnimation = Tween<double>(
        begin: widget.scaleFactor,
        end: 1.0,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _animationDone = true);
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //if (_animationDone) widget.child,
          widget.child,
          if (!_animationDone)
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, __) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 150,
                      height: 49,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class TestingPage2 extends StatelessWidget {
  const TestingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransitionOverlay(
          targetPage: const RewardsScreen(),
          child: CustomButton(label: 'testing'),
        ),
      ),
    );
  }
}
