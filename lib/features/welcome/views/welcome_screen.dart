import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons.dart';
import 'package:le_petit_davinci/core/widgets/pill_button.dart';

class WelcomeScreen extends StatefulWidget {
  final VoidCallback? onContinue;

  const WelcomeScreen({super.key, this.onContinue});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background (same as splash screen)
            Positioned.fill(
              child: SvgPicture.asset(
                SvgAssets.bgSplash,
                fit: BoxFit.cover,
                semanticsLabel: 'Welcome background',
              ),
            ),
            
            // Welcome content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    
                    // Welcome message
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        fontFamily: 'DynaPuff_SemiCondensed',
                        fontSize: 32,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ).animate().fadeIn(duration: const Duration(milliseconds: 800)),
                    
                    const SizedBox(height: 12),
                    
                    // App title
                    Text(
                      'Le Petit Davinci',
                      style: TextStyle(
                        fontFamily: 'DynaPuff_SemiCondensed',
                        fontSize: 42,
                        color: AppColors.bluePrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ).animate().fadeIn(
                      duration: const Duration(milliseconds: 800), 
                      delay: const Duration(milliseconds: 300)
                    ).slideY(
                      begin: 0.3, 
                      end: 0, 
                      curve: Curves.easeOutQuad
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Description text
                    Text(
                      'Start your learning adventure with colorful letters and fun activities!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'DynaPuff_SemiCondensed',
                        fontSize: 18,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate().fadeIn(
                      duration: const Duration(milliseconds: 800), 
                      delay: const Duration(milliseconds: 600)
                    ),
                    
                    const Spacer(flex: 3),
                    
                    // Continue button
                    PillButton(
                      label: 'Continue',
                      icon: const Icon(Icons.arrow_forward),
                      iconPosition: IconPosition.right,
                      size: ButtonSize.lg,
                      width: 200,
                      onPressed: widget.onContinue,
                    ).animate().fadeIn(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 1000),
                    ).scale(
                      begin: const Offset(0.9, 0.9),
                      end: const Offset(1.0, 1.0),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      delay: const Duration(milliseconds: 1000),
                    ),
                    
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}