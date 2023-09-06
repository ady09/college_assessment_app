enum QuestionType { dropdown, yesNo, text }

class Question {
  final String text;
  final QuestionType type;
  final List<String>? options;
   int currentQuestionIndex;

  Question({
    required this.text,
    required this.type,
    this.options,
    required this.currentQuestionIndex,
  });
}
