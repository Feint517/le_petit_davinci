import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:le_petit_davinci/features/lessons/french/models/alphabet_model.dart';

class AlphabetLessonController extends GetxController
    with GetTickerProviderStateMixin {
  // Rx variables pour l'état de l'UI
  final RxInt currentSectionIndex = 0.obs;
  final RxInt currentLetterIndex = 0.obs;
  final RxBool isLetterExpanded = false.obs;
  final RxBool isPlaying = false.obs;
  final RxBool isAnimating = false.obs;
  final RxBool isLoaded = false.obs;
  final RxDouble progression = 0.0.obs;
  final RxInt points = 0.obs;
  final RxInt selectedTabIndex = 0.obs;

  // Modèle de données
  late List<AlphabetSection> sections;

  // Pour l'audio
  final audioPlayer = AudioPlayer();
  final FlutterTts flutterTts = FlutterTts();

  // Pour l'animation
  late TabController tabController;
  late Animation<double> letterScaleAnimation;
  late AnimationController animationController;

  // Propriétés calculées
  AlphabetSection get currentSection => sections[currentSectionIndex.value];
  AlphabetLetter get currentLetter =>
      currentSection.letters.isNotEmpty
          ? currentSection.letters[currentLetterIndex.value %
              currentSection.letters.length]
          : AlphabetData.allLetters.first;

  @override
  void onInit() {
    super.onInit();

    // Initialiser les sections
    sections = AlphabetData.sections;

    // Initialiser le TTS
    _initTts();

    // Initialiser l'animation
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    letterScaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    // Initialiser le TabController
    tabController = TabController(
      length: 4, // Étude, Exercices, Animation, Vidéo
      vsync: this,
    );

    tabController.addListener(() {
      selectedTabIndex.value = tabController.index;
    });

    // Marquer comme chargé
    isLoaded.value = true;
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    flutterTts.stop();
    animationController.dispose();
    tabController.dispose();
    super.onClose();
  }

  // Initialiser le TTS
  Future<void> _initTts() async {
    try {
      await flutterTts.setLanguage("fr-FR");
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);
    } catch (e) {
      debugPrint("Erreur d'initialisation TTS: $e");
    }
  }

  // Jouer le son d'une lettre
  Future<void> playLetterSound(AlphabetLetter letter) async {
    try {
      isPlaying.value = true;

      // Animer la lettre
      animationController.forward().then((_) => animationController.reverse());

      // Essayer de jouer le fichier audio s'il existe et qu'il est accessible
      if (letter.audioPath != null) {
        try {
          // Vérifier si le fichier audio existe avant de le charger
          await audioPlayer.setAsset(letter.audioPath!);
          await audioPlayer.play();
          await Future.delayed(const Duration(milliseconds: 500));
        } catch (e) {
          debugPrint("Erreur audio: $e");
          // Fallback: utiliser TTS si le fichier audio n'est pas trouvé
          await _speakLetter(letter);
        }
      } else {
        // Pas de fichier audio, utiliser TTS
        await _speakLetter(letter);
      }

      // Prononcer le mot d'exemple après la lettre
      await Future.delayed(const Duration(milliseconds: 800));
      await flutterTts.speak(letter.exampleWord);

      // Augmenter les points
      points.value += 1;
    } catch (e) {
      debugPrint("Erreur lors de la lecture: $e");
    } finally {
      isPlaying.value = false;
    }
  }

  // Prononcer une lettre avec TTS
  Future<void> _speakLetter(AlphabetLetter letter) async {
    await flutterTts.speak(letter.letter);
  }

  // Passer à la section suivante
  void nextSection() {
    if (currentSectionIndex.value < sections.length - 1) {
      currentSectionIndex.value++;
      currentLetterIndex.value = 0;
      progression.value = currentSectionIndex.value / (sections.length - 1);
    }
  }

  // Revenir à la section précédente
  void previousSection() {
    if (currentSectionIndex.value > 0) {
      currentSectionIndex.value--;
      currentLetterIndex.value = 0;
      progression.value = currentSectionIndex.value / (sections.length - 1);
    }
  }

  // Passer à la lettre suivante
  void nextLetter() {
    if (currentLetterIndex.value < currentSection.letters.length - 1) {
      currentLetterIndex.value++;
    } else if (currentSectionIndex.value < sections.length - 1) {
      // Passer à la section suivante si nous sommes à la dernière lettre
      nextSection();
    }
  }

  // Revenir à la lettre précédente
  void previousLetter() {
    if (currentLetterIndex.value > 0) {
      currentLetterIndex.value--;
    } else if (currentSectionIndex.value > 0) {
      // Revenir à la section précédente si nous sommes à la première lettre
      previousSection();
      // Aller à la dernière lettre de la section précédente
      currentLetterIndex.value =
          sections[currentSectionIndex.value].letters.length - 1;
    }
  }

  // Basculer l'état d'expansion d'une lettre
  void toggleLetterExpanded() {
    isLetterExpanded.value = !isLetterExpanded.value;
  }

  // Changer l'index de l'onglet
  void changeTabIndex(int index) {
    tabController.animateTo(index);
  }
}
