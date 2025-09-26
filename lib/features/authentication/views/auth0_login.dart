import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';  
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/authentication/widgets/social_login_button.dart';

class Auth0LoginView extends StatelessWidget {
  const Auth0LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              
              // Logo and Title
              Column(
                children: [
                  Image.asset(
                    SvgAssets.logoBlue,
                    height: 120,
                    width: 120,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Welcome to Le Petit Davinci',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Learn, play, and create with us!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              
              const SizedBox(height: 48),
              
              // Social Login Buttons
              Column(
                children: [
                  // Google Login
                  SocialLoginButton(
                    onTap: () {},
                    icon: Icons.g_mobiledata,
                    label: 'Continue with Google',
                    backgroundColor: Colors.white,
                    textColor: Colors.black87,
                    isLoading: false,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Facebook Login
                  SocialLoginButton(
                    onTap: () {},
                    icon: Icons.facebook,
                    label: 'Continue with Facebook',
                    backgroundColor: const Color(0xFF1877F2),
                    textColor: Colors.white,
                    isLoading: false,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Microsoft Login
                  SocialLoginButton(
                    onTap: () {},
                    icon: Icons.business,
                    label: 'Continue with Microsoft',
                    backgroundColor: const Color(0xFF00BCF2),
                    textColor: Colors.white,
                    isLoading: false,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Divider
                  Row(
                    children: [
                      const Expanded(child: Divider(color: Colors.white54)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: Colors.white54)),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Universal Login Button
                  CustomButton(
                    label: 'Login with Auth0',
                    onPressed: () {},
                    variant: ButtonVariant.secondary,
                    isLoading: false,
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Footer
              Text(
                'By continuing, you agree to our Terms of Service and Privacy Policy',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white60,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
