import 'package:college_assessment_app/src/common_widgets/drop_down_list/drop_down_widget.dart';
import 'package:college_assessment_app/src/features/authentication/controllers/assessment_controller.dart';

import 'package:college_assessment_app/src/features/authentication/screens/assessment_screen/text_answer.dart';
import 'package:college_assessment_app/src/features/authentication/screens/assessment_screen/yes_no_question.dart';
import 'package:college_assessment_app/src/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';

import '../../models/assessment.dart';

class SubHeaderContainerWidget extends StatelessWidget {
  SubHeaderContainerWidget(
      {super.key, required this.questionNo, required this.question});

  final String questionNo;
  final String question;
 
  final AssessmentController _assessmentController = AssessmentController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.26,
      width: width * 1,
      decoration: BoxDecoration(
        color: const Color.fromARGB(57, 225, 225, 222),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            width: 1,
            color: const Color.fromARGB(40, 159, 159, 155),
            style: BorderStyle.solid),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              questionNo,
              style: CustomTextTheme.smContentTitle,
            ),
            SizedBox(height: height * 0.024),
            Text(
              question,
              style: CustomTextTheme.questionTitleStyle,
            ),

            SizedBox(height: height * 0.024),
            if (_assessmentController.currentQuestion.type == QuestionType.dropdown)
              DropDownWidget(
                question: _assessmentController.currentQuestion,
              ),
            if (_assessmentController.currentQuestion.type == QuestionType.yesNo)
              YesNoQuestion(
                question: _assessmentController.currentQuestion,
              ),
            if (_assessmentController.currentQuestion.type == QuestionType.text)
              TextQuestion(
                question: _assessmentController.currentQuestion,
              ),
          ],
        ),
      ),
    );
  }
}

