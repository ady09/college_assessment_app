

enum QuestionType { dropdown, yesNo, text }

class Question {
  final String text;
  final QuestionType type;
  final List<String>? options;

  Question({
    required this.text,
    required this.type,
    this.options,
  });
}


