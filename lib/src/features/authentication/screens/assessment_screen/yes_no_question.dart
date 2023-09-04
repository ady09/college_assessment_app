import 'package:college_assessment_app/src/features/authentication/controllers/assessment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/assessment.dart';

class YesNoQuestion extends StatelessWidget {

  
final AssessmentController assessmentController =
      Get.put(AssessmentController());

  final Question question;

  YesNoQuestion({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
             assessmentController.setAnswer(
               assessmentController.currentQuestionIndex.value,
              'Yes',
            );
          },
          child: const Text('Yes'),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {
            assessmentController.setAnswer(
            assessmentController.currentQuestionIndex.value,
              'No',
            );
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}