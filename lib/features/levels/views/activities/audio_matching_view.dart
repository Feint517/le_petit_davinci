import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/features/levels/models/activities/audio_matching_activity.dart';
import 'package:le_petit_davinci/features/levels/models/audio_pair_model.dart';
import 'package:le_petit_davinci/features/levels/widgets/activity_intro_wrapper.dart';

class AudioMatchingActivityView extends StatefulWidget {
  const AudioMatchingActivityView({super.key, required this.activity});

  final AudioMatchingActivity activity;

  @override
  State<AudioMatchingActivityView> createState() =>
      _AudioMatchingActivityViewState();
}

class _AudioMatchingActivityViewState extends State<AudioMatchingActivityView> {
  final _audioPlayer = AudioPlayer();

  late List<AudioWordPair> shuffledAudio;
  late List<AudioWordPair> shuffledWords;
  final Set<String> matchedWords = {};

  int? selectedAudioIndex;
  int? selectedWordIndex;

  @override
  void initState() {
    super.initState();
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
    return ActivityIntroWrapper(
      activity: _buildMainContent(),
      mascotMixin: widget.activity,
      // startButtonText: 'Start Exercise',
      // onStartPressed: () {
      //   widget.activity.isIntroCompleted.value = true;
      // },
    );
  }

  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Column(
        children: [
          Text(
            widget.activity.prompt,
            style: Get.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //* Audio Buttons Column
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      shuffledAudio.asMap().entries.expand((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        final isMatched = matchedWords.contains(item.word);
                        final button = _buildChoiceButton(
                          icon: Icons.volume_up,
                          onTap: isMatched ? null : () => _onAudioTap(index),
                          isSelected: selectedAudioIndex == index,
                          isMatched: isMatched,
                        );
                        if (index < shuffledAudio.length - 1) {
                          return [button, const Gap(24)];
                        }
                        return [button];
                      }).toList(),
                ),
                //* Word Buttons Column
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      shuffledWords.asMap().entries.expand((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        final isMatched = matchedWords.contains(item.word);
                        final button = _buildChoiceButton(
                          text: item.word,
                          onTap: isMatched ? null : () => _onWordTap(index),
                          isSelected: selectedWordIndex == index,
                          isMatched: isMatched,
                        );
                        if (index < shuffledWords.length - 1) {
                          return [button, const Gap(24)];
                        }
                        return [button];
                      }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceButton({
    IconData? icon,
    String? text,
    VoidCallback? onTap,
    bool isSelected = false,
    bool isMatched = false,
  }) {
    final color =
        isMatched
            ? Colors.green.shade100
            : (isSelected ? Colors.blue.shade100 : Colors.grey.shade200);
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
          child:
              icon != null
                  ? Icon(icon, size: 30)
                  : Text(
                    text!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
        ),
      ),
    );
  }
}
