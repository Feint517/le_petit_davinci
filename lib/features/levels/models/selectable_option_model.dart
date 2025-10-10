class SelectableOption {
  final String label;
  final String imagePath;
  final bool isNetworkImage;
  final String? question;

  SelectableOption({
    required this.label, 
    required this.imagePath,
    this.isNetworkImage = false,
    this.question,
  });
}
