/// Represents a single memory card
class MemoryCard {
  final String id;
  final String frontImage; // Image shown when card is face down
  final String backContent; // Content shown when card is face up (image/text)
  final String? audioAsset; // Optional audio for the card
  final CardType type; // Whether it's an image, text, or audio card
  final String? label; // Optional label for the card

  const MemoryCard({
    required this.id,
    required this.frontImage,
    required this.backContent,
    this.audioAsset,
    required this.type,
    this.label,
  });
}

/// Represents a pair of matching cards
class CardPair {
  final String pairId;
  final MemoryCard card1;
  final MemoryCard card2;
  final String?
  pairDescription; // Optional description of what the pair represents

  const CardPair({
    required this.pairId,
    required this.card1,
    required this.card2,
    this.pairDescription,
  });
}

/// Types of memory cards
enum CardType {
  image, // Card shows an image
  text, // Card shows text
  audio, // Card plays audio when flipped
}

/// Game difficulty levels
enum MemoryDifficulty {
  easy, // 4 cards (2 pairs)
  medium, // 8 cards (4 pairs)
  hard, // 12 cards (6 pairs)
}

/// Game state for tracking progress
class MemoryGameState {
  final List<MemoryCard> allCards;
  final List<MemoryCard> flippedCards;
  final List<CardPair> matchedPairs;
  final int moves;
  final int timeElapsed; // in seconds
  final bool isGameComplete;

  const MemoryGameState({
    required this.allCards,
    required this.flippedCards,
    required this.matchedPairs,
    required this.moves,
    required this.timeElapsed,
    required this.isGameComplete,
  });

  MemoryGameState copyWith({
    List<MemoryCard>? allCards,
    List<MemoryCard>? flippedCards,
    List<CardPair>? matchedPairs,
    int? moves,
    int? timeElapsed,
    bool? isGameComplete,
  }) {
    return MemoryGameState(
      allCards: allCards ?? this.allCards,
      flippedCards: flippedCards ?? this.flippedCards,
      matchedPairs: matchedPairs ?? this.matchedPairs,
      moves: moves ?? this.moves,
      timeElapsed: timeElapsed ?? this.timeElapsed,
      isGameComplete: isGameComplete ?? this.isGameComplete,
    );
  }
}
