import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';

class ExitLevelModal extends StatefulWidget {
  const ExitLevelModal({
    super.key,
    required this.onCancel,
    required this.onExit,
  });

  final VoidCallback onCancel;
  final VoidCallback onExit;

  @override
  State<ExitLevelModal> createState() => _ExitLevelModalState();
}

class _ExitLevelModalState extends State<ExitLevelModal>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Container(
          color: Colors.black.withValues(alpha: _fadeAnimation.value * 0.5),
          child: SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(AppSizes.lg),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Handle bar
                    Container(
                      margin: const EdgeInsets.only(top: AppSizes.md),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.grey.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    const SizedBox(height: AppSizes.lg),

                    // Warning icon with animation
                    _buildAnimatedIcon(),

                    const SizedBox(height: AppSizes.lg),

                    // Title
                    Text(
                      'Exit Level?',
                      style: Get.textTheme.headlineSmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppSizes.sm),

                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.lg,
                      ),
                      child: Text(
                        'Are you sure you want to leave this level? Your progress will be saved and you can continue later.',
                        style: Get.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: AppSizes.xl),

                    // Action buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.lg,
                      ),
                      child: Row(
                        children: [
                          // Cancel button
                          Expanded(
                            child: _buildActionButton(
                              label: 'Continue Learning',
                              onPressed: widget.onCancel,
                              variant: ButtonVariant.ghost,
                            ),
                          ),

                          const SizedBox(width: AppSizes.md),

                          // Exit button
                          Expanded(
                            child: _buildActionButton(
                              label: 'Exit Level',
                              onPressed: widget.onExit,
                              variant: ButtonVariant.warning,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSizes.lg),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedIcon() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.warning.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.exit_to_app_rounded,
              size: 40,
              color: AppColors.warning,
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback onPressed,
    required ButtonVariant variant,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
        decoration: BoxDecoration(
          color: _getButtonColor(variant),
          borderRadius: BorderRadius.circular(12),
          border:
              variant == ButtonVariant.ghost
                  ? Border.all(color: AppColors.grey.withValues(alpha: 0.3))
                  : null,
          boxShadow:
              variant != ButtonVariant.ghost
                  ? [
                    BoxShadow(
                      color: _getButtonColor(variant).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
        child: Text(
          label,
          style: Get.textTheme.titleSmall?.copyWith(
            color: _getTextColor(variant),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Color _getButtonColor(ButtonVariant variant) {
    switch (variant) {
      case ButtonVariant.ghost:
        return Colors.transparent;
      case ButtonVariant.warning:
        return AppColors.warning;
      default:
        return AppColors.primary;
    }
  }

  Color _getTextColor(ButtonVariant variant) {
    switch (variant) {
      case ButtonVariant.ghost:
        return AppColors.textSecondary;
      case ButtonVariant.warning:
        return AppColors.white;
      default:
        return AppColors.white;
    }
  }
}

enum ButtonVariant { primary, secondary, success, warning, ghost }
