import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/lessons/french/models/alphabet_model.dart';

class AlphabetCard extends StatelessWidget {
  final AlphabetLetter letter;
  final int index;
  final bool isExpanded;
  final bool isSelected;
  final bool isPlaying;
  final VoidCallback onTap;
  final Animation<double>? animation;

  const AlphabetCard({
    super.key,
    required this.letter,
    required this.index,
    required this.onTap,
    this.isExpanded = false,
    this.isSelected = false,
    this.isPlaying = false,
    this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.light : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: letter.getColor(index),
          width: isSelected ? 3 : 2,
        ),
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: letter.getColor(index).withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
                : null,
      ),
      child:
          isExpanded ? _buildExpandedCard(context) : _buildCompactCard(context),
    );
  }

  Widget _buildCompactCard(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedBuilder(
          animation: animation ?? const AlwaysStoppedAnimation(1.0),
          builder: (context, child) {
            return Transform.scale(
              scale: animation?.value ?? 1.0,
              child: child,
            );
          },
          child: Container(
            height: 75,
            width: 75,
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  letter.displayForm,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: letter.getColor(index),
                  ),
                ),
                if (isPlaying)
                  const SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedCard(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Lettre principale
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: letter.getColor(index).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      letter.displayForm,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: letter.getColor(index),
                      ),
                    ),
                  ),

                  // Prononciation
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.light,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      letter.pronunciation,
                      style: const TextStyle(
                        fontFamily: 'Bricolage Grotesque',
                        fontSize: 14,
                        color: AppColors.dark,
                      ),
                    ),
                  ),
                ],
              ),

              const Gap(16),

              // Exemple et traduction
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: letter.getColor(index).withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // Mot d'exemple
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Exemple:",
                            style: TextStyle(
                              fontFamily: 'Bricolage Grotesque',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            letter.exampleWord,
                            style: TextStyle(
                              fontFamily: 'Bricolage Grotesque',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: letter.getColor(index),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Traduction
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Traduction:",
                            style: TextStyle(
                              fontFamily: 'Bricolage Grotesque',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            letter.exampleWordTranslation,
                            style: const TextStyle(
                              fontFamily: 'Bricolage Grotesque',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              if (isPlaying)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.grey,
                          ),
                        ),
                      ),
                      const Gap(8),
                      Text(
                        "Lecture...",
                        style: TextStyle(
                          fontFamily: 'Bricolage Grotesque',
                          fontSize: 12,
                          color: letter.getColor(index),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
