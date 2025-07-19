import 'package:flutter/material.dart';

class TimelineStep extends StatelessWidget {
  final String label;
  final bool isFirst;
  final bool isLast;

  const TimelineStep({
    super.key,
    required this.label,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          // Draw the vertical line (timeline)
          Positioned(
            left: 32,
            top: isFirst ? 50 : 0,
            bottom: isLast ? 50 : 0,
            child: Container(
              width: 4,
              color: Colors.blue.shade100,
            ),
          ),
          // Draw the curved step (circle)
          Positioned(
            left: 16,
            top: 40,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.3),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Icon(Icons.check, color: Colors.white),
            ),
          ),
          // Label
          Positioned(
            left: 64,
            top: 40,
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}