import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final bool isLoading;

  const SocialLoginButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Icon
                Icon(icon, color: textColor, size: 24),
                const SizedBox(width: 16),

                // Label
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // Loading indicator
                if (isLoading)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(textColor),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
