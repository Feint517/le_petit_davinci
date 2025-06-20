import 'package:flutter/material.dart';

class AlphabetLetter {
  final String letter;
  final String uppercase;
  final String lowercase;
  final String pronunciation;
  final String exampleWord;
  final String exampleWordTranslation;
  final String? audioPath;
  final Color? color;
  final String? imagePath;
  
  const AlphabetLetter({
    required this.letter,
    required this.uppercase,
    required this.lowercase,
    required this.pronunciation,
    required this.exampleWord,
    required this.exampleWordTranslation,
    this.audioPath,
    this.color,
    this.imagePath,
  });

  String get displayForm => "$uppercase$lowercase";
  
  // Récupérer la couleur ou une couleur par défaut
  Color getColor(int index) {
    if (color != null) return color!;
    
    // Couleurs alternées en fonction de l'index
    final List<Color> colors = [
      const Color(0xFFBBA2FF), // Purple
      const Color(0xFFFF725E), // Orange
      const Color(0xFF13BB87), // Green
      const Color(0xFFFFC107), // Amber
    ];
    
    return colors[index % colors.length];
  }
}

class AlphabetSection {
  final String title;
  final String description;
  final List<AlphabetLetter> letters;
  
  const AlphabetSection({
    required this.title,
    required this.description,
    required this.letters,
  });
}

class AlphabetData {
  // Lettres de l'alphabet français avec leur prononciation et exemples
  static final List<AlphabetLetter> allLetters = [
    const AlphabetLetter(
      letter: "a",
      uppercase: "A",
      lowercase: "a",
      pronunciation: "[a]",
      exampleWord: "Avion",
      exampleWordTranslation: "Airplane",
      audioPath: "assets/sfx/dictee/a.mp3", // Ajuster le chemin si nécessaire
    ),
    const AlphabetLetter(
      letter: "b",
      uppercase: "B",
      lowercase: "b",
      pronunciation: "[be]",
      exampleWord: "Ballon",
      exampleWordTranslation: "Ball",
      audioPath: "assets/sfx/letters/b.mp3",
    ),
    const AlphabetLetter(
      letter: "c",
      uppercase: "C",
      lowercase: "c",
      pronunciation: "[se]",
      exampleWord: "Chat",
      exampleWordTranslation: "Cat",
      audioPath: "assets/sfx/letters/c.mp3",
    ),
    const AlphabetLetter(
      letter: "d",
      uppercase: "D",
      lowercase: "d",
      pronunciation: "[de]",
      exampleWord: "Danse",
      exampleWordTranslation: "Dance",
      audioPath: "assets/sfx/letters/d.mp3",
    ),
    const AlphabetLetter(
      letter: "e",
      uppercase: "E",
      lowercase: "e",
      pronunciation: "[ə]",
      exampleWord: "Enfant",
      exampleWordTranslation: "Child",
      audioPath: "assets/sfx/letters/e.mp3",
    ),
    const AlphabetLetter(
      letter: "f",
      uppercase: "F",
      lowercase: "f",
      pronunciation: "[ɛf]",
      exampleWord: "Fraise",
      exampleWordTranslation: "Strawberry",
      audioPath: "assets/sfx/letters/f.mp3",
    ),
    const AlphabetLetter(
      letter: "g",
      uppercase: "G",
      lowercase: "g",
      pronunciation: "[ʒe]",
      exampleWord: "Gâteau",
      exampleWordTranslation: "Cake",
      audioPath: "assets/sfx/letters/g.mp3",
    ),
    const AlphabetLetter(
      letter: "h",
      uppercase: "H",
      lowercase: "h",
      pronunciation: "[aʃ]",
      exampleWord: "Hérisson",
      exampleWordTranslation: "Hedgehog",
      audioPath: "assets/sfx/letters/h.mp3",
    ),
    const AlphabetLetter(
      letter: "i",
      uppercase: "I",
      lowercase: "i",
      pronunciation: "[i]",
      exampleWord: "Île",
      exampleWordTranslation: "Island",
      audioPath: "assets/sfx/letters/i.mp3",
    ),
    const AlphabetLetter(
      letter: "j",
      uppercase: "J",
      lowercase: "j",
      pronunciation: "[ʒi]",
      exampleWord: "Jardin",
      exampleWordTranslation: "Garden",
      audioPath: "assets/sfx/letters/j.mp3",
    ),
    const AlphabetLetter(
      letter: "k",
      uppercase: "K",
      lowercase: "k",
      pronunciation: "[ka]",
      exampleWord: "Kiwi",
      exampleWordTranslation: "Kiwi",
      audioPath: "assets/sfx/letters/k.mp3",
    ),
    const AlphabetLetter(
      letter: "l",
      uppercase: "L",
      lowercase: "l",
      pronunciation: "[ɛl]",
      exampleWord: "Livre",
      exampleWordTranslation: "Book",
      audioPath: "assets/sfx/letters/l.mp3",
    ),
    const AlphabetLetter(
      letter: "m",
      uppercase: "M",
      lowercase: "m",
      pronunciation: "[ɛm]",
      exampleWord: "Maison",
      exampleWordTranslation: "House",
      audioPath: "assets/sfx/letters/m.mp3",
    ),
    const AlphabetLetter(
      letter: "n",
      uppercase: "N",
      lowercase: "n",
      pronunciation: "[ɛn]",
      exampleWord: "Neige",
      exampleWordTranslation: "Snow",
      audioPath: "assets/sfx/letters/n.mp3",
    ),
    const AlphabetLetter(
      letter: "o",
      uppercase: "O",
      lowercase: "o",
      pronunciation: "[o]",
      exampleWord: "Oiseau",
      exampleWordTranslation: "Bird",
      audioPath: "assets/sfx/letters/o.mp3",
    ),
    const AlphabetLetter(
      letter: "p",
      uppercase: "P",
      lowercase: "p",
      pronunciation: "[pe]",
      exampleWord: "Pomme",
      exampleWordTranslation: "Apple",
      audioPath: "assets/sfx/letters/p.mp3",
    ),
    const AlphabetLetter(
      letter: "q",
      uppercase: "Q",
      lowercase: "q",
      pronunciation: "[ky]",
      exampleWord: "Quatre",
      exampleWordTranslation: "Four",
      audioPath: "assets/sfx/letters/q.mp3",
    ),
    const AlphabetLetter(
      letter: "r",
      uppercase: "R",
      lowercase: "r",
      pronunciation: "[ɛʁ]",
      exampleWord: "Rouge",
      exampleWordTranslation: "Red",
      audioPath: "assets/sfx/letters/r.mp3",
    ),
    const AlphabetLetter(
      letter: "s",
      uppercase: "S",
      lowercase: "s",
      pronunciation: "[ɛs]",
      exampleWord: "Soleil",
      exampleWordTranslation: "Sun",
      audioPath: "assets/sfx/letters/s.mp3",
    ),
    const AlphabetLetter(
      letter: "t",
      uppercase: "T",
      lowercase: "t",
      pronunciation: "[te]",
      exampleWord: "Table",
      exampleWordTranslation: "Table",
      audioPath: "assets/sfx/letters/t.mp3",
    ),
    const AlphabetLetter(
      letter: "u",
      uppercase: "U",
      lowercase: "u",
      pronunciation: "[y]",
      exampleWord: "Une",
      exampleWordTranslation: "One",
      audioPath: "assets/sfx/letters/u.mp3",
    ),
    const AlphabetLetter(
      letter: "v",
      uppercase: "V",
      lowercase: "v",
      pronunciation: "[ve]",
      exampleWord: "Vélo",
      exampleWordTranslation: "Bicycle",
      audioPath: "assets/sfx/letters/v.mp3",
    ),
    const AlphabetLetter(
      letter: "w",
      uppercase: "W",
      lowercase: "w",
      pronunciation: "[dubləve]",
      exampleWord: "Wagon",
      exampleWordTranslation: "Wagon",
      audioPath: "assets/sfx/letters/w.mp3",
    ),
    const AlphabetLetter(
      letter: "x",
      uppercase: "X",
      lowercase: "x",
      pronunciation: "[iks]",
      exampleWord: "Xylophone",
      exampleWordTranslation: "Xylophone",
      audioPath: "assets/sfx/letters/x.mp3",
    ),
    const AlphabetLetter(
      letter: "y",
      uppercase: "Y",
      lowercase: "y",
      pronunciation: "[igʁɛk]",
      exampleWord: "Yaourt",
      exampleWordTranslation: "Yogurt",
      audioPath: "assets/sfx/letters/y.mp3",
    ),
    const AlphabetLetter(
      letter: "z",
      uppercase: "Z",
      lowercase: "z",
      pronunciation: "[zɛd]",
      exampleWord: "Zèbre",
      exampleWordTranslation: "Zebra",
      audioPath: "assets/sfx/letters/z.mp3",
    ),
  ];
  
  // Sections d'apprentissage
  static final List<AlphabetSection> sections = [
    AlphabetSection(
      title: "L'Alphabet Français",
      description: "Apprenez les 26 lettres de l'alphabet français et leur prononciation.",
      letters: allLetters,
    ),
    AlphabetSection(
      title: "Les Voyelles",
      description: "Les lettres A, E, I, O, U sont des voyelles qui ont un son propre.",
      letters: allLetters.where((l) => "aeiou".contains(l.letter)).toList(),
    ),
    AlphabetSection(
      title: "Les Consonnes",
      description: "Les consonnes sont les lettres qui ne sont pas des voyelles.",
      letters: allLetters.where((l) => !"aeiou".contains(l.letter)).toList(),
    ),
    AlphabetSection(
      title: "Les Sons Spéciaux",
      description: "En français, certaines combinaisons de lettres créent des sons uniques.",
      letters: [
        const AlphabetLetter(
          letter: "é",
          uppercase: "É",
          lowercase: "é",
          pronunciation: "[e]",
          exampleWord: "École",
          exampleWordTranslation: "School",
        ),
        const AlphabetLetter(
          letter: "è",
          uppercase: "È",
          lowercase: "è",
          pronunciation: "[ɛ]",
          exampleWord: "Père",
          exampleWordTranslation: "Father",
        ),
        const AlphabetLetter(
          letter: "ê",
          uppercase: "Ê",
          lowercase: "ê",
          pronunciation: "[ɛ]",
          exampleWord: "Fête",
          exampleWordTranslation: "Party",
        ),
        const AlphabetLetter(
          letter: "ç",
          uppercase: "Ç",
          lowercase: "ç",
          pronunciation: "[s]",
          exampleWord: "Garçon",
          exampleWordTranslation: "Boy",
        ),
        const AlphabetLetter(
          letter: "à",
          uppercase: "À",
          lowercase: "à",
          pronunciation: "[a]",
          exampleWord: "Là",
          exampleWordTranslation: "There",
        ),
      ],
    ),
  ];
}