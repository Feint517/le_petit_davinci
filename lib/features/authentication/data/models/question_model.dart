class QuestionOption {
  final String value;
  final String title;
  final String? subtitle;
  final dynamic iconWidget;

  QuestionOption({
    required this.value,
    required this.title,
    this.subtitle,
    this.iconWidget,
  });
}

class QuestionModel {
  final String questionText;
  final List<QuestionOption> options;

  QuestionModel({required this.questionText, required this.options});
}
