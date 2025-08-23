class NumberMatchingExercise {
  final List<NumberMatchingItem> items;
  final String instruction;

  const NumberMatchingExercise({
    required this.items,
    required this.instruction,
  });
}

class NumberMatchingItem {
  final String number;
  final String imageAsset;
  final int quantity;

  const NumberMatchingItem({
    required this.number,
    required this.imageAsset,
    required this.quantity,
  });
}
