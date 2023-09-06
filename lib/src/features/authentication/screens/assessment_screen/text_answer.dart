import 'package:college_assessment_app/src/features/authentication/controllers/assessment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/assessment.dart';

class TextQuestion extends StatelessWidget {
  final Question question;
  final AssessmentController assessmentController =
      Get.find();

  TextQuestion({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: 'Your Answer'),
      onChanged: (value) {
        assessmentController.setAnswer(
          assessmentController.currentQuestionIndex.value,
          value,
        );
      },
    );
  }
}
