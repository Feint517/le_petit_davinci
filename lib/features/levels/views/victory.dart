import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/features/levels/controllers/victory_controller.dart';
import 'package:le_petit_davinci/features/levels/widgets/stars_section.dart';

class VictoryScreen extends StatefulWidget {
  const VictoryScreen({super.key, required this.starsCount});

  final int starsCount;

  @override
  State<VictoryScreen> createState() => _VictoryScreenState();
}

class _VictoryScreenState extends State<VictoryScreen>
    with TickerProviderStateMixin {
  rive.Artboard? _artboard;
  rive.StateMachineController? _stateMachineController;
  rive.SimpleAnimation? _simpleAnimation;
  bool _isLoaded = false;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize scale animation
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _loadRiveAnimation();
  }

  Future<void> _loadRiveAnimation() async {
    try {
      final data = await DefaultAssetBundle.of(
        context,
      ).load(AnimationAssets.happyBear);
      final file = rive.RiveFile.import(data);
      final artboard = file.mainArtboard;

      setState(() {
        _artboard = artboard;
        _isLoaded = true;
      });

      // Start scale animation when mascot is loaded
      _scaleController.forward();

      // Try to get the state machine controller
      _stateMachineController = rive.StateMachineController.fromArtboard(
        artboard,
        'State Machine 1',
      );

      if (_stateMachineController != null) {
        artboard.addController(_stateMachineController!);
        // Trigger animation after a short delay
        Future.delayed(const Duration(milliseconds: 500), () {
          _triggerAnimation();
        });
      } else {
        // Fallback to simple animation
        _simpleAnimation = rive.SimpleAnimation('Animation 1');
        artboard.addController(_simpleAnimation!);
        _simpleAnimation!.isActive = true;
      }
    } catch (e) {
      debugPrint('Error loading Rive animation: $e');
    }
  }

  void _triggerAnimation() {
    if (_stateMachineController != null) {
      try {
        final inputs = _stateMachineController!.findInput('Trigger');
        if (inputs != null) {
          inputs.value = true;
        }
      } catch (e) {
        debugPrint('Error triggering animation: $e');
      }
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _stateMachineController?.dispose();
    _simpleAnimation?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ResponsiveImageAsset(
                assetPath: SvgAssets.gamesBackground,
                width: DeviceUtils.getScreenWidth(),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: SizedBox.expand(
                child: Column(
                  spacing: 20,
                  children: [
                    const Gap(AppSizes.spaceBtwSections * 2),
                    Text(
                      'Level Completed!',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Animated Rive mascot with scale animation
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child:
                            _isLoaded && _artboard != null
                                ? rive.Rive(artboard: _artboard!)
                                : const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                  ),
                                ),
                      ),
                    ),
                    const Gap(AppSizes.spaceBtwSections),
                    StarsSection(starsCount: widget.starsCount),
                    const Gap(AppSizes.spaceBtwSections),
                    // Master of Sounds Badge
                    Container(
                      padding: const EdgeInsets.all(AppSizes.sm),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppSizes.md),
                        border: Border.all(
                          color: AppColors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Congratulations!',
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(AppSizes.xs),
                          Text(
                            'You\'ve earned the',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: AppColors.white.withOpacity(0.9),
                            ),
                          ),
                          const Gap(AppSizes.xs),
                          ResponsiveImageAsset(
                            assetPath: SvgAssets.masterOfSounds,
                            width: 180,
                            height: 60,
                          ),
                          const Gap(AppSizes.xs),
                          Text(
                            'Badge!',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: AppColors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      label: 'Continue',
                      onPressed:
                          () =>
                              Get.find<VictoryController>()
                                  .navigateToMapScreen(),
                    ),
                    Gap(DeviceUtils.getBottomNavigationBarHeight()),
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
