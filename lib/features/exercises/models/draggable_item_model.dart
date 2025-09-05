class DraggableItem {
  final String id; // A unique ID, can be the asset path itself
  final int value;
  final String assetPath;

  const DraggableItem({
    required this.id,
    required this.value,
    required this.assetPath,
  });
}