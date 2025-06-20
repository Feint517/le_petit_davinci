import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/features/lessons/french/controllers/alphabet_lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons/french/widgets/alphabet_card.dart';
import 'package:lottie/lottie.dart';

class AlphabetLessonScreen extends StatelessWidget {
  const AlphabetLessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AlphabetLessonController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          // Afficher un écran de chargement si nécessaire
          if (!controller.isLoaded.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // Section title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        controller.currentSection.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDeep,
                        ),
                      ),
                    ),
                    if (!controller.isLetterExpanded.value)
                      TextButton.icon(
                        onPressed: controller.toggleLetterExpanded,
                        icon: const Icon(Icons.grid_view, size: 16),
                        label: const Text("Voir tout"),
                        style: ButtonStyle(
                          foregroundColor: WidgetStateProperty.all(
                            AppColors.purple,
                          ),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Description de la section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  controller.currentSection.description,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),

              const Gap(16),

              // Tabs
              TabBar(
                controller: controller.tabController,
                indicatorColor: AppColors.primaryDeep,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: AppColors.primaryDeep,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BricolageGrotesque',
                ),
                tabs: const [
                  Tab(text: "Diction"),
                  Tab(text: "Étude"),
                  Tab(text: "Exercices"),
                  Tab(text: "Vidéo"),
                ],
              ),

              // Tab content
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    //AlphabetPrononciation(),
                    // Tab 1: Étude des lettres
                    _buildStudyTab(controller),

                    // Tab 2: Exercices
                    _buildExercisesTab(controller),

                    // Tab 3: Animation
                    _buildAnimationTab(controller),

                    // Tab 4: Vidéo
                    _buildVideoTab(controller),
                  ],
                ),
              ),

              // Navigation buttons
            ],
          );
        }),
      ),
    );
  }

  // Tab 1: Étude des lettres
  Widget _buildStudyTab(AlphabetLessonController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(() {
        // Vérifier si la section contient des lettres pour éviter les erreurs
        if (controller.currentSection.letters.isEmpty) {
          return const Center(
            child: Text("Aucune lettre disponible dans cette section"),
          );
        }

        // Si une lettre est agrandie, afficher sa carte détaillée
        if (controller.isLetterExpanded.value) {
          return Column(
            children: [
              Expanded(
                child: AlphabetCard(
                  letter: controller.currentLetter,
                  index: controller.currentLetterIndex.value,
                  isExpanded: true,
                  isSelected: true,
                  isPlaying: controller.isPlaying.value,
                  onTap: () {
                    if (!controller.isPlaying.value) {
                      controller.playLetterSound(controller.currentLetter);
                    }
                  },
                  animation: controller.letterScaleAnimation,
                ),
              ),

              // Navigation des lettres
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: controller.previousLetter,
                    icon: const Icon(Icons.arrow_back_ios, size: 16),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        AppColors.purple,
                      ),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => controller.toggleLetterExpanded(),
                    icon: const Icon(Icons.grid_view, size: 16),
                    label: const Text("Voir tout"),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.grey.shade200,
                      ),
                      foregroundColor: WidgetStateProperty.all(Colors.black87),
                    ),
                  ),
                  IconButton(
                    onPressed: controller.nextLetter,
                    icon: const Icon(Icons.arrow_forward_ios, size: 16),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        AppColors.orange,
                      ),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        // Sinon, afficher la grille de lettres
        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: controller.currentSection.letters.length,
                itemBuilder: (context, index) {
                  final letter = controller.currentSection.letters[index];
                  final isSelected =
                      controller.currentLetterIndex.value == index;

                  return AlphabetCard(
                    letter: letter,
                    index: index,
                    isSelected: isSelected,
                    isPlaying: isSelected && controller.isPlaying.value,
                    onTap: () {
                      controller.currentLetterIndex.value = index;
                      controller.toggleLetterExpanded();
                    },
                    animation:
                        isSelected ? controller.letterScaleAnimation : null,
                  );
                },
              ),
            ),

            // Instructions
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Touchez une lettre pour voir plus de détails et entendre sa prononciation.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // Tab 2: Exercices d'alphabet
  Widget _buildExercisesTab(AlphabetLessonController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ResponsiveSvgAsset(assetPath: SvgAssets.happyGift, width: 100),
          const Gap(20),
          const Text(
            "Exercices de prononciation",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Gap(10),
          const Text(
            "Pratique la prononciation des lettres et mots",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const Gap(20),
          ElevatedButton.icon(
            onPressed: () {
              // todo: Naviguer vers les exercices
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text("Commencer les exercices"),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.accent),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tab 3: Animation des lettres
  Widget _buildAnimationTab(AlphabetLessonController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(LottieAssets.confetti, height: 150, repeat: true),
          const Gap(20),
          const Text(
            "Animation des lettres",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Gap(10),
          const Text(
            "Regarde comment les lettres sont formées",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const Gap(20),
          ElevatedButton.icon(
            onPressed: () {
              // todo: Lancer l'animation
            },
            icon: const Icon(Icons.play_circle_outline),
            label: const Text("Voir l'animation"),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.primaryDeep),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tab 4: Vidéo éducative
  Widget _buildVideoTab(AlphabetLessonController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 180,
            width: 320,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.video_library,
              size: 60,
              color: Colors.grey,
            ),
          ),
          const Gap(20),
          const Text(
            "Vidéo éducative",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Gap(10),
          const Text(
            "Regarde une vidéo sur l'alphabet français",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const Gap(20),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Lancer la vidéo
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text("Regarder la vidéo"),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
