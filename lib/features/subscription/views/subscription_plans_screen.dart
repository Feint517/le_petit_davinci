import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';

class PremiumSubscriptionPage extends StatelessWidget {
  const PremiumSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6B73FF), Color(0xFF9B59B6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6B73FF).withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Crown Icon
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.stars,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Unlock Premium!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Get access to amazing features that make learning super fun!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Features Section
              const Text(
                'What you\'ll get:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),

              const SizedBox(height: 20),

              // Feature Cards
              _buildFeatureCard(
                icon: Icons.lock_open,
                iconColor: const Color(0xFF10B981),
                title: 'Unlimited Access',
                description: 'Learn from 1000+ fun lessons and activities!',
                gradient: [const Color(0xFF10B981), const Color(0xFF059669)],
              ),

              const SizedBox(height: 16),

              _buildFeatureCard(
                icon: Icons.download_outlined,
                iconColor: const Color(0xFF3B82F6),
                title: 'Offline Learning',
                description: 'Download lessons and learn anywhere, anytime!',
                gradient: [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)],
              ),

              const SizedBox(height: 16),

              _buildFeatureCard(
                icon: Icons.emoji_events,
                iconColor: const Color(0xFFF59E0B),
                title: 'Special Rewards',
                description: 'Earn exclusive badges and certificates!',
                gradient: [const Color(0xFFF59E0B), const Color(0xFFD97706)],
              ),

              const SizedBox(height: 16),

              _buildFeatureCard(
                icon: Icons.insights,
                iconColor: const Color(0xFFEF4444),
                title: 'Progress Tracking',
                description: 'See detailed reports of your learning journey!',
                gradient: [const Color(0xFFEF4444), const Color(0xFFDC2626)],
              ),

              const SizedBox(height: 16),

              _buildFeatureCard(
                icon: Icons.support_agent,
                iconColor: const Color(0xFF8B5CF6),
                title: 'Priority Support',
                description: 'Get help from our friendly team anytime!',
                gradient: [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)],
              ),

              const SizedBox(height: 32),

              // Pricing Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          '\$9.99',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6B73FF),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 12.0),
                          child: Text(
                            '/month',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '7-day free trial',
                        style: TextStyle(
                          color: Color(0xFF10B981),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // CTA Button
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B6B), Color(0xFFFFE66D)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF6B6B).withOpacity(0.4),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement Stripe payment
                    _handleSubscription(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Start Free Trial',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Terms
              const Text(
                'Cancel anytime • No commitment',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required List<Color> gradient,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubscription(BuildContext context) {
    // TODO: Implement Stripe payment integration
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.payment, color: Color(0xFF6B73FF)),
              SizedBox(width: 8),
              Text('Payment Integration'),
            ],
          ),
          content: const Text(
            'Here you would integrate with Stripe payment processing. '
            'The subscription flow would handle:\n\n'
            '• Customer creation\n'
            '• Payment method setup\n'
            '• Subscription creation\n'
            '• Webhook handling',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Got it!'),
            ),
          ],
        );
      },
    );
  }
}

class PremiumSubscriptionPage2 extends StatelessWidget {
  const PremiumSubscriptionPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: ResponsiveImageAsset(
              assetPath: 'assets/svg/pin2_background.svg',
            ),
          ),
          SafeArea(
            left: false,
            right: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Subscription Plans',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Gap(AppSizes.spaceBtwSections),
                  PlanCard(
                    planName: 'Plus',
                    features: ['Access to video content', 'Access to Games'],
                    price: 9.99,
                  ),
                  const Gap(AppSizes.spaceBtwSections),
                  PlanCard(
                    planName: 'Premium',
                    features: [
                      'Access to video content',
                      'Access to Games',
                      'More statistics controls',
                    ],
                    price: 14.99,
                  ),
                  const Gap(AppSizes.spaceBtwSections * 5.5),
                  ResponsiveImageAsset(
                    assetPath: SvgAssets.StripeLogo,
                    width: 100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.planName,
    required this.features,
    required this.price,
  });

  final String planName;
  final List<String> features;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      alignment: Alignment.topLeft,
      width: DeviceUtils.getScreenWidth(),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(planName, style: Theme.of(context).textTheme.headlineSmall),
          const Gap(10),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check, color: AppColors.primary),
                  const Gap(10),
                  Text(feature),
                ],
              ),
            ),
          ),
          const Gap(10),
          CustomButton(
            variant: ButtonVariant.secondary,
            label: 'Start Free Trial then \$ $price/month',
          ),
        ],
      ),
    );
  }
}
