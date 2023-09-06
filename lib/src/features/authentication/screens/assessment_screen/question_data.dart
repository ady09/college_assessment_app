import '../../models/assessment.dart';

class QuestionData {
  final List<Question> questions = [
    Question(
      text: 'How would you rate the faculty in terms of qualifications and teaching effectiveness',
      type: QuestionType.dropdown,
      options: ['1', '2', '3', '4', '5','Please Select an option'],
      currentQuestionIndex: 1
    ),
    Question(
      text: 'Did you find the academic advising services helpful in planning your courses and career path?',
      type: QuestionType.yesNo, currentQuestionIndex: 2,
    ),
    Question(
      text: 'How well did the college prepare you for your future career or further education?',
      type: QuestionType.text, currentQuestionIndex: 3,
    ),
    Question(
      text: 'On a scale of 1 to 5, how would you rate your overall college experience?',
      type: QuestionType.yesNo, currentQuestionIndex: 4,
    ),
    Question(
      text: 'Did you feel safe on campus? Were there any security concerns?',
      type: QuestionType.text, currentQuestionIndex: 5,
    ),
  ];

  final List<dynamic> answers = [null, null, null, null, null];

  get currentQuestionIndex => null;
}