class ListenAndMatchItem {
  final String audioAsset;
  final List<String> options; //? image asset paths
  final int correctIndex;

  ListenAndMatchItem({
    required this.audioAsset,
    required this.options,
    required this.correctIndex,
  });
}
