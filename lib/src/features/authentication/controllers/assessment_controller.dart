import 'package:college_assessment_app/src/features/authentication/screens/assessment_screen/question_data.dart';
import 'package:college_assessment_app/src/features/authentication/screens/home_screen/home_screen.dart';

import 'package:get/get.dart';

import '../models/assessment.dart';

class AssessmentController extends GetxController {
  final QuestionData data = QuestionData();

  final RxInt currentQuestionIndex = 0.obs;
  RxBool isDisabled = false.obs;
  
  static AssessmentController get find => Get.find();

  // final AssessmentController _controller = Get.put(AssessmentController());

  // Question get currentQuestion => data.questions[currentQuestionIndex.value];

  void onNextQuestion(int currentQuestionFirebase) {
    if (currentQuestionFirebase < data.questions.length) {
      currentQuestionIndex.value = currentQuestionFirebase;
      currentQuestionFirebase++;
    } else {
      Get.to(HomeScreen());
      print(currentQuestionFirebase);
    }
  }

  Question getCurrentQuestion(int currentQuestionFirebase) {
    if (currentQuestionFirebase < data.questions.length) {
  
      return data.questions[currentQuestionFirebase];
    }
    return data.questions[currentQuestionFirebase - 1];
  }

  dynamic getAnswer(int index) {
    return data.answers[index];
  }

  void setAnswer(int index, dynamic answer) {
    data.answers[index] = answer;
  }
}
