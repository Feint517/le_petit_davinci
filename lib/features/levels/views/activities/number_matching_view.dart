import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/exercises/models/number_matching_exercise_model.dart';

class NumberMatchingView extends StatefulWidget {
  final NumberMatchingExercise exercise;

  const NumberMatchingView({super.key, required this.exercise});

  @override
  State<NumberMatchingView> createState() => _NumberMatchingViewState();
}

class _NumberMatchingViewState extends State<NumberMatchingView> {
  // Map to track which number is connected to which image
  Map<String, String?> connections = {};

  @override
  void initState() {
    super.initState();
    for (var item in widget.exercise.items) {
      connections[item.number] = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.exercise.instruction,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                // Left side: Numbers
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        widget.exercise.items
                            .map((item) => _buildDraggableNumber(item.number))
                            .toList(),
                  ),
                ),

                // Right side: Images with quantities
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        widget.exercise.items
                            .map(
                              (item) => _buildImageTarget(
                                item.imageAsset,
                                item.quantity,
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Check answer button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _checkAnswers,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Vérifier',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDraggableNumber(String number) {
    return Draggable<String>(
      data: number,
      feedback: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      childWhenDragging: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Text(
          number,
          style: TextStyle(
            color: AppColors.darkGrey.withOpacity(0.5),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildImageTarget(String imageAsset, int quantity) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:
                candidateData.isNotEmpty
                    ? AppColors.secondary.withOpacity(0.3)
                    : Colors.transparent,
            border: Border.all(color: AppColors.secondary, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Image.asset(imageAsset, height: 80),
              const SizedBox(height: 8),
              Text(
                connections.entries.any((e) => e.value == imageAsset)
                    ? connections.entries
                        .firstWhere((e) => e.value == imageAsset)
                        .key
                    : '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGrey,
                ),
              ),
            ],
          ),
        );
      },
      onAccept: (String number) {
        setState(() {
          // Remove previous connection if exists
          if (connections[number] != null) {
            connections[number] = null;
          }
          // Set new connection
          connections[number] = imageAsset;
        });
      },
    );
  }

  void _checkAnswers() {
    // Logic to verify if all numbers are matched correctly with their quantities
    bool allCorrect = true;
    for (var item in widget.exercise.items) {
      if (connections[item.number] != item.imageAsset) {
        allCorrect = false;
        break;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          allCorrect
              ? 'Bravo! Toutes les réponses sont correctes!'
              : 'Essaie encore!',
        ),
        backgroundColor: allCorrect ? Colors.green : Colors.red,
      ),
    );
  }
}
