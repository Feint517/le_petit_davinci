class DraggableItem {
  final String id;
  final String label;
  final int value;
  final String? imageAsset;

  const DraggableItem({
    required this.id,
    required this.label,
    required this.value,
    this.imageAsset,
  });
}
