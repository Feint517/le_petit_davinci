// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AlphabetPrononciationController extends GetxController {
  TextStyle textStyle = TextStyle(fontSize: 12);
  final List<String> tabs = ["Étude", "Exercices", "Animation", "Vidéo"];
  final RxBool isMuted = false.obs;
  final AudioPlayer audioPlayer = AudioPlayer();

  // Track the active letter for visual feedback
  final RxInt activeLetterIndex = (-1).obs;

  // Add this to track animation state for letters
  final RxInt tappedLetterIndex = (-1).obs;

  final List<String> letters = [
    "Aa",
    "Bb",
    "Cc",
    "Dd",
    "Ee",
    "Ff",
    "Gg",
    "Hh",
    "Ii",
    "Jj",
    "Kk",
    "Ll",
    "Mm",
    "Nn",
    "Oo",
    "Pp",
    "Qq",
    "Rr",
    "Ss",
    "Tt",
    "Uu",
    "Vv",
    "Ww",
    "Xx",
    "Yy",
    "Zz",
  ];

  final List<String> lesson = [
    "Contenu 1 - Les Bases de l'Alphabet Français",
    "Contenu 2 - Les Chiffres en Français",
    "Contenu 3 - Les Jours de la Semaine",
  ];

  // Vibrant colors for kids
  final List<Color> borderColors = [
    Color(0xFFFF5252), // Bright Red
    Color(0xFF448AFF), // Bright Blue
    Color(0xFFFFD740), // Amber
    Color(0xFF64FFDA), // Teal
    Color(0xFFE040FB), // Purple
    Color(0xFF76FF03), // Light Green
    Color(0xFFFF6E40), // Deep Orange
    Color(0xFF69F0AE), // Green
    Color(0xFF536DFE), // Indigo
    Color(0xFFFFAB40), // Orange
    Color(0xFF7C4DFF), // Deep Purple
    Color(0xFFB388FF), // Purple Light
    Color(0xFF18FFFF), // Cyan
    Color(0xFFFF4081), // Pink
    Color(0xFFFFEA00), // Yellow
    Color(0xFF1DE9B6), // Teal Light
    Color(0xFF00E676), // Green Light
    Color(0xFFFF9E80), // Deep Orange Light
    Color(0xFF40C4FF), // Light Blue
    Color(0xFFFFD180), // Orange Light
    Color(0xFF80D8FF), // Light Blue Light
    Color(0xFFEA80FC), // Purple Accent
    Color(0xFFCCFF90), // Light Green Light
    Color(0xFFA7FFEB), // Teal Accent
    Color(0xFFFF80AB), // Pink Light
    Color(0xFFB9F6CA), // Green Accent
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize audio player settings
    audioPlayer.setVolume(1.0);
  }

  // Handle letter tap - both audio and animation
  void handleLetterTap(int index) {
    // Add haptic feedback
    HapticFeedback.lightImpact();

    // Set tapped index for animation
    tappedLetterIndex.value = index;

    // Reset tapped index after animation completes
    Future.delayed(Duration(milliseconds: 400), () {
      tappedLetterIndex.value = -1;
    });

    // Play the corresponding sound
    playSound(letters[index]);
  }

  // Play individual letter sound
  Future<void> playSound(String letter) async {
    if (isMuted.value) return;

    try {
      // Visual feedback
      activeLetterIndex.value = letters.indexOf(letter);

      // Stop any currently playing sound
      await audioPlayer.stop();

      // Get the first character and make it lowercase
      String soundFile = letter[0].toLowerCase();

      // Try loading and playing the audio
      try {
        // Try MP3 format first
        await audioPlayer.setAsset('assets/sfx/alphabet/$soundFile.mp3');
        await audioPlayer.play();
      } catch (e) {
        print('MP3 failed, trying WAV: $e');

        // If MP3 fails, try WAV
        try {
          await audioPlayer.setAsset('assets/sfx/alphabet/$soundFile.wav');
          await audioPlayer.play();
        } catch (e) {
          print('WAV failed, trying OGG: $e');

          // If WAV fails, try OGG
          await audioPlayer.setAsset('assets/sfx/alphabet/$soundFile.ogg');
          await audioPlayer.play();
        }
      }

      // Reset active letter after sound plays
      await Future.delayed(Duration(milliseconds: 800));
      activeLetterIndex.value = -1;
    } catch (e) {
      print('Error playing sound: $e');
      activeLetterIndex.value = -1;

      // Show a subtle error notification if all formats fail
      Get.snackbar(
        'Audio Notification',
        'Sound might not be available. Check your audio files.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber.withValues(alpha: 0.7),
        duration: Duration(seconds: 2),
      );
    }
  }

  // Toggle mute
  void toggleMute() {
    isMuted.value = !isMuted.value;
    if (isMuted.value) {
      audioPlayer.stop();
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
