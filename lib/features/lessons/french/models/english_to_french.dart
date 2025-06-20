class EnglishToFrench {
  final String englishSentence;
  final String frenchSentence;

  EnglishToFrench({
    required this.englishSentence,
    required this.frenchSentence,
  });

  // Optional: Add factory method to create from JSON if you'll store data that way
  factory EnglishToFrench.fromJson(Map<String, dynamic> json) {
    return EnglishToFrench(
      englishSentence: json['englishSentence'] as String,
      frenchSentence: json['frenchSentence'] as String,
    );
  }

  // Optional: Add toJson method if you'll store data that way
  Map<String, dynamic> toJson() {
    return {
      'englishSentence': englishSentence,
      'frenchSentence': frenchSentence,
    };
  }
}