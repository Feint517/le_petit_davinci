import 'dart:math';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:le_petit_davinci/features/lessons3/models/activity_model.dart';

class AudioMatchingActivityView extends StatefulWidget {
  const AudioMatchingActivityView({super.key, required this.activity});
  final AudioMatchingActivity activity;

  @override
  State<AudioMatchingActivityView> createState() => _AudioMatchingActivityViewState();
}

class _AudioMatchingActivityViewState extends State<AudioMatchingActivityView> {
  final _audioPlayer = AudioPlayer();

  // Game State
  late List<AudioWordPair> shuffledAudio;
  late List<AudioWordPair> shuffledWords;
  final Set<String> matchedWords = {};

  int? selectedAudioIndex;
  int? selectedWordIndex;

  @override
  void initState() {
    super.initState();
    // Create shuffled lists for the UI so the game is challenging.
    shuffledAudio = List.from(widget.activity.pairs)..shuffle(Random());
    shuffledWords = List.from(widget.activity.pairs)..shuffle(Random());
  }

  void _onAudioTap(int index) {
    _audioPlayer.setAsset(shuffledAudio[index].audioAssetPath);
    _audioPlayer.play();
    setState(() {
      selectedAudioIndex = index;
    });
    _checkMatch();
  }

  void _onWordTap(int index) {
    setState(() {
      selectedWordIndex = index;
    });
    _checkMatch();
  }

  void _checkMatch() {
    if (selectedAudioIndex != null && selectedWordIndex != null) {
      final audioChoice = shuffledAudio[selectedAudioIndex!];
      final wordChoice = shuffledWords[selectedWordIndex!];

      // Check if the selected audio and word belong to the same original pair.
      if (audioChoice.word == wordChoice.word) {
        // Correct Match!
        setState(() {
          matchedWords.add(wordChoice.word);
          selectedAudioIndex = null;
          selectedWordIndex = null;
        });

        // Check for win condition
        if (matchedWords.length == widget.activity.pairs.length) {
          // All pairs matched, complete the activity.
          widget.activity.isCompleted.value = true;
        }
      } else {
        // Incorrect Match - reset selection after a short delay
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            selectedAudioIndex = null;
            selectedWordIndex = null;
          });
        });
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(widget.activity.prompt, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Audio Buttons Column
              _buildButtonColumn(shuffledAudio.length, (index) {
                final item = shuffledAudio[index];
                final isMatched = matchedWords.contains(item.word);
                return _buildChoiceButton(
                  icon: Icons.volume_up,
                  onTap: isMatched ? null : () => _onAudioTap(index),
                  isSelected: selectedAudioIndex == index,
                  isMatched: isMatched,
                );
              }),
              // Word Buttons Column
              _buildButtonColumn(shuffledWords.length, (index) {
                final item = shuffledWords[index];
                final isMatched = matchedWords.contains(item.word);
                return _buildChoiceButton(
                  text: item.word,
                  onTap: isMatched ? null : () => _onWordTap(index),
                  isSelected: selectedWordIndex == index,
                  isMatched: isMatched,
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonColumn(int count, Widget Function(int index) builder) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(count, builder),
    );
  }

  Widget _buildChoiceButton({IconData? icon, String? text, VoidCallback? onTap, bool isSelected = false, bool isMatched = false}) {
    final color = isMatched ? Colors.green.shade100 : (isSelected ? Colors.blue.shade100 : Colors.grey.shade200);
    final borderColor = isSelected ? Colors.blue : Colors.grey.shade400;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Center(
          child: icon != null ? Icon(icon, size: 30) : Text(text!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}