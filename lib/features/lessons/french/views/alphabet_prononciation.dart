import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/lessons/french/controllers/alphabet_prononciation_controller.dart';

class AlphabetPrononciation extends StatefulWidget {
  const AlphabetPrononciation({super.key});

  @override
  State<AlphabetPrononciation> createState() => _AlphabetPrononciationState();
}

class _AlphabetPrononciationState extends State<AlphabetPrononciation>
    with TickerProviderStateMixin {
  // Animation controllers - reduced to only necessary ones
  late AnimationController _instructionAnimController;
  late List<AnimationController> _letterAnimControllers = [];

  // Controller
  late AlphabetPrononciationController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the GetX controller
    controller = Get.put(AlphabetPrononciationController());

    // Only keep necessary animation controllers
    _instructionAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    // Create animation controllers for each letter's subtle pulse
    _letterAnimControllers = List.generate(
      controller.letters.length,
      (index) =>
          AnimationController(vsync: this, duration: const Duration(seconds: 2))
            ..repeat(reverse: true),
    );
  }

  @override
  void dispose() {
    _instructionAnimController.dispose();
    for (var controller in _letterAnimControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios_rounded, color: AppColors.textPrimary),
      //     onPressed: () => Get.back(),
      //   ),
      //   title: Text(
      //     "Prononciation de l'alphabet",
      //     style: TextStyle(
      //       fontSize: 18,
      //       fontFamily: "BricolageGrotesque",
      //       fontWeight: FontWeight.w600,
      //       color: AppColors.textPrimary,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: Stack(
        children: [
          // Improved background decoration
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.pink.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: -15,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.3,
            right: -15,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Instruction text
                Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.amber.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.touch_app_rounded,
                              color: Colors.amber.shade800,
                              size: 18,
                            ),
                          ),
                          Gap(12),
                          Expanded(
                            child: Text(
                              "Toucher une lettre pour entendre son son!",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "BricolageGrotesque",
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .animate(controller: _instructionAnimController)
                    .fadeIn(duration: Duration(milliseconds: 600))
                    .slideY(begin: -0.2, end: 0),

                // Letter Grid
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6, // Increased from 5 to 6
                        crossAxisSpacing: 10, // Further reduced spacing
                        mainAxisSpacing: 10, // Further reduced spacing
                        childAspectRatio: 0.9, // Slightly taller than wide
                      ),
                      itemCount: controller.letters.length,
                      itemBuilder: (context, index) {
                        // Create staggered entry animation
                        final delay = Duration(milliseconds: index * 50);
                        final entranceAnim = AnimationController(
                          vsync: this,
                          duration: Duration(milliseconds: 400),
                        );

                        // Start entrance animation after a delay
                        Future.delayed(delay, () {
                          if (mounted) entranceAnim.forward();
                        });

                        return Obx(() {
                          // Reactive check if this letter is currently tapped
                          final bool isTapped =
                              controller.tappedLetterIndex.value == index;

                          return GestureDetector(
                            onTap: () => controller.handleLetterTap(index),
                            child: Container(
                                  margin: EdgeInsets.all(
                                    2,
                                  ), // Added margin between cards
                                  padding: EdgeInsets.all(
                                    4,
                                  ), // Added internal padding
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        controller.borderColors[index]
                                            .withValues(alpha: 0.8),
                                        controller.borderColors[index]
                                            .withValues(alpha: 0.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: controller.borderColors[index]
                                            .withValues(
                                              alpha: isTapped ? 0.4 : 0.2,
                                            ),
                                        blurRadius: isTapped ? 8 : 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Text(
                                        controller.letters[index],
                                        style: TextStyle(
                                          fontSize:
                                              18, // Even smaller font size
                                          fontFamily: "BricolageGrotesque",
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                // Base subtle pulse animation (continuous)
                                .animate(
                                  controller: _letterAnimControllers[index],
                                )
                                .scale(
                                  begin: Offset(1, 1),
                                  end: Offset(1.05, 1.05),
                                  duration: Duration(seconds: 2),
                                  curve: Curves.easeInOut,
                                )
                                // Initial entry animation (one-time)
                                .animate(controller: entranceAnim)
                                .fadeIn(duration: Duration(milliseconds: 400))
                                .slideY(
                                  begin: 0.3,
                                  end: 0,
                                  duration: Duration(milliseconds: 400),
                                )
                                // Tap animation (conditional)
                                .animate(target: isTapped ? 1 : 0)
                                .scale(
                                  begin: Offset(1, 1),
                                  end: Offset(
                                    1.2,
                                    1.2,
                                  ), // Smaller scale increase
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeOut,
                                )
                                .then()
                                .scale(
                                  begin: Offset(1.2, 1.2),
                                  end: Offset(1, 1),
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                )
                                // Additional feedback animation for children
                                .then()
                                .rotate(
                                  begin: 0,
                                  end: 0.05,
                                  duration: Duration(milliseconds: 100),
                                )
                                .then()
                                .rotate(
                                  begin: 0.05,
                                  end: -0.05,
                                  duration: Duration(milliseconds: 100),
                                )
                                .then()
                                .rotate(
                                  begin: -0.05,
                                  end: 0,
                                  duration: Duration(milliseconds: 100),
                                ),
                          );
                        });
                      },
                    ),
                  ),
                ),

                // Bottom mascot or hint
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.volume_up_rounded,
                            color: AppColors.primary.withValues(alpha: 0.7),
                            size: 20,
                          ),
                          Gap(8),
                          Text(
                            "Écoute et répète chaque lettre!",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "BricolageGrotesque",
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.8,
                              ),
                            ),
                          ),
                        ],
                      )
                      .animate()
                      .fadeIn(delay: Duration(milliseconds: 800))
                      .slideY(
                        begin: 0.2,
                        end: 0,
                        delay: Duration(milliseconds: 800),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
