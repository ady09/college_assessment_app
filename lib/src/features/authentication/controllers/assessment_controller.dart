
import 'package:college_assessment_app/src/features/authentication/screens/assessment_screen/question_data.dart';

import 'package:get/get.dart';

import '../models/assessment.dart';


class AssessmentController extends GetxController {
  final QuestionData data = QuestionData();
  final RxInt currentQuestionIndex = 0.obs;

  static AssessmentController get find => Get.find();


  Question get currentQuestion => data.questions[currentQuestionIndex.value];

  void onNextQuestion() {
    if (currentQuestionIndex.value < data.questions.length - 1) {
      currentQuestionIndex.value++;
    } else {
      // Handle end of survey
    }
  }

  dynamic getAnswer(int index) {
    return data.answers[index];
  }

  void setAnswer(int index, dynamic answer) {
    data.answers[index] = answer;
  }

}
