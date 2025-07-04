import 'package:flutter/material.dart';

class RevealRoute extends PageRouteBuilder {
  final Widget page;
  final Offset origin;
  final Color color;

  RevealRoute({required this.page, required this.origin, required this.color})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Stack(
            children: [
              child,
              // Shrinking circle overlay
              AnimatedBuilder(
                animation: animation,
                builder: (context, _) {
                  double size =
                      MediaQuery.of(context).size.longestSide *
                      1.2 *
                      (1 - animation.value);
                  return size > 0.1
                      ? Positioned(
                        left: origin.dx - size / 2,
                        top: origin.dy - size / 2,
                        child: Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                      : const SizedBox.shrink();
                },
              ),
            ],
          );
        },
      );
}
