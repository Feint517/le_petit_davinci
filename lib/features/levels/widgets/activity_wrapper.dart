import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/widgets/standard_activity_navigation.dart';

/// Wrapper that provides consistent layout for all activities
/// Handles the separation between activity content and navigation
class ActivityWrapper extends StatelessWidget {
  const ActivityWrapper({
    super.key,
    required this.activity,
    this.showNavigation = true,
  });

  final Widget activity;
  final bool showNavigation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Activity content
        Expanded(child: activity),

        // Standard navigation (if enabled)
        if (showNavigation) const StandardActivityNavigation(),
      ],
    );
  }
}

/// Extension to easily wrap activities with standard navigation
extension ActivityWrapperExtension on Widget {
  Widget withStandardNavigation({bool showNavigation = true}) {
    return ActivityWrapper(activity: this, showNavigation: showNavigation);
  }
}
