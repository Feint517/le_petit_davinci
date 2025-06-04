import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
// Assuming AppColors is defined in core/constants/colors.dart,



/// A customizable button widget with various styles and states.
///
/// Supports different variants, sizes, icons, and loading states.
class ProfileCards extends StatelessWidget {
  /// The text to display on the button
  final String? username;
  final String? label;
  final Color? labelColor;
  final Widget? picture;
  final Color backgroundColor;
  final Color shadowColor;

  /// Callback function when the button is pressed
  final VoidCallback? onPressed;

  // Removed width and height from here to allow content-based sizing
  // final double? width;
  // final double? height;

  const ProfileCards({
    super.key,
    this.username,
    this.picture,
    // this.height, // Removed
    this.label,
    this.onPressed,
    // this.width, // Removed
    required this.backgroundColor,
    required this.shadowColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Added GestureDetector to make the card tappable
      onTap: onPressed,
      child: Container(
        // Removed width and height here to allow content-based sizing
        // width: width,
        // height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 2,
              blurRadius: 0,
              offset: const Offset(5, 5), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Row(
                // 'spacing' is not a property of Row. Use SizedBox for spacing.
                mainAxisSize: MainAxisSize.min, // Make Row take minimum space horizontally
                mainAxisAlignment: MainAxisAlignment.start, // Align content to start
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: shadowColor, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 24, // Explicitly set a radius for the avatar
                      backgroundColor: Colors.grey[200], // Placeholder background
                      child: picture ?? const Icon(Icons.person, size: 30, color: AppColors.textWhite), // Default icon
                    ),
                  ),
                  const SizedBox(width: 10), // Add horizontal spacing between avatar and text

                  Expanded( // Use Expanded to allow the Column to take available space
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Make Column take minimum space vertically
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
                      children: [
                        if (username != null)
                          Text(
                            username!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textWhite,
                            ),
                            overflow: TextOverflow.ellipsis, // Prevent overflow with ellipsis
                            maxLines: 1, // Limit to one line
                          ),
                        if (label != null)
                          Text(
                            label!,
                            style: TextStyle(
                              fontSize: 12,
                              color: labelColor ?? AppColors.textWhite,
                            ),
                            overflow: TextOverflow.ellipsis, // Prevent overflow with ellipsis
                            maxLines: 1, // Limit to one line
                          ),
                      ],
                    ),
                  ),
                ],
              ).animate().fadeIn(),
        ),
      ),
    );
  }
}
