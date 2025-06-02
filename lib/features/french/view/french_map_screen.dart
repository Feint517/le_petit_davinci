import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart'; 
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/home/widgets/profile_header.dart';

class FrenchMapScreen extends StatefulWidget {
  const FrenchMapScreen({super.key});

  @override
  State<FrenchMapScreen> createState() => _FrenchMapScreenState();
}

class _FrenchMapScreenState extends State<FrenchMapScreen> {
  final GlobalKey _svgKey = GlobalKey();

  double? _svgRenderedWidth;
  double? _svgRenderedHeight;

  @override
  void initState() {
    super.initState();
    // Schedule a callback to run after the widget has been built and laid out
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getSvgRenderedDimensions();
    });
  }

  void _getSvgRenderedDimensions() {
    // Check if the key's current context is mounted and has a RenderBox
    if (_svgKey.currentContext != null) {
      final RenderBox renderBox = _svgKey.currentContext!.findRenderObject() as RenderBox;
      // It's good practice to check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          _svgRenderedWidth = renderBox.size.width;
          _svgRenderedHeight = renderBox.size.height;
        });
        print('SVG Rendered Width: $_svgRenderedWidth');
        print('SVG Rendered Height: $_svgRenderedHeight');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ProfileHeader(
              userName: 'Alex',
              userClass: 'Classe 2',
              changeAvatar: false,
            ),
            _buildNavigation('French', context),
            Gap(10.h),
            _buildPageContent(
              "Aujourd'hui, on va jouer avec les mots et écrire comme un auteur !",
              context,
              1, // Current level
              3, // Max level
            ),
            Gap(10.h),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    // Assign the GlobalKey to your SvgPicture.asset
                    child: SvgPicture.asset(
                      SvgAssets.frenchMapBackground,
                      fit: BoxFit.cover,
                      key: _svgKey, // Key is correctly assigned here
                      alignment: Alignment.topCenter, // Keeps top uncropped
                    ),
                  ),

                  // Conditionally render the buttons ONLY if dimensions are known
                  if (_svgRenderedWidth != null && _svgRenderedHeight != null) ...[
                    // First button at the beginning of the road
                    Positioned(
                      // Left position based on rendered width
                      left: _svgRenderedWidth! * 0.4,
                      // Top position based on rendered height (adjust multiplier as needed)
                      top: _svgRenderedHeight! * 0.82, // Example: 65% down from the top
                      child: _buildMapButton(
                        SvgAssets.headset,
                        AppColors.bluePrimary,
                        AppColors.blueSecondary,
                      ),
                    ),

                    // Second button at the middle of the road
                    Positioned(
                      // Right position based on rendered width
                      right: _svgRenderedWidth! * 0.05,
                      // Top position based on rendered height (adjust multiplier as needed)
                      top: _svgRenderedHeight! * 0.5, // Example: 35% down from the top
                      child: _buildMapButton(
                        SvgAssets.chat,
                        AppColors.pinkLight,
                        AppColors.pinkPrimary,
                         
                      ),
                    ),

                    // Third button at the end of the road
                    Positioned(
                      // Left position based on rendered width
                      left: _svgRenderedWidth! * 0.4,
                      // Top position based on rendered height (adjust multiplier as needed)
                      top: _svgRenderedHeight! * 0.2, // Example: 5% down from the top
                      child: _buildMapButton(
                        SvgAssets.explore,
                        AppColors.purple,
                        AppColors.purpleSecondary,
                      ),
                    ),
                  ],
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Removed the 'Key key' parameter as it was not used for the SvgPicture inside.
  Widget _buildMapButton(String iconPath, Color color, Color shadowColor) {
    return Container(
      width: 70.w, // Using .w for responsive width
      height: 70.h, // Using .h for responsive height
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            spreadRadius: 2,
            blurRadius: 0,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          iconPath,
          height: 40.h, // Example size for the icon inside the button
          width: 40.w,
        ),
      ),
    );
  }

  Widget _buildNavigation(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.borderSecondary,
            ),
            child: TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              label: const Text('Home', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.primaryBlue,
            ),
            child: Center(child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent(String paragraph, BuildContext context, int currentlevel, int maxLevel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Text(paragraph, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Gap(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: AppColors.primaryBlue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // spacing: 5, // 'spacing' is not a property of Row directly. Use Gap or SizedBox between children.
                  children: [
                    SvgPicture.asset(SvgAssets.learnHat, height: 20.h, width: 20.w),
                    Gap(5.w), // Added Gap for spacing
                    const Text('Explorateur des mots', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Text('Niveau $currentlevel/$maxLevel', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}