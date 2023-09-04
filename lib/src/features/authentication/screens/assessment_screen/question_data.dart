import '../../models/assessment.dart';

class QuestionData {
  final List<Question> questions = [
    Question(
      text: 'How would you rate the faculty in terms of qualifications and teaching effectiveness',
      type: QuestionType.dropdown,
      options: ['1', '2', '3', '4', '5'],
    ),
    Question(
      text: 'Do you like pizza?',
      type: QuestionType.yesNo,
    ),
    Question(
      text: 'What is your name?',
      type: QuestionType.text,
    ),
  ];

  final List<dynamic> answers = [null, null, null];
}