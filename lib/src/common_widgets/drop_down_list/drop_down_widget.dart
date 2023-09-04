import 'package:college_assessment_app/src/features/authentication/controllers/assessment_controller.dart';
import 'package:college_assessment_app/src/features/authentication/models/assessment.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  DropDownWidget({super.key, required this.question});

  final Question question;
  
  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  final AssessmentController _assessmentController = AssessmentController();
  // ignore: unused_field
  String _currentSelection = "0";

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          style: TextStyle(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
          underline: SizedBox(),
          elevation: 16,
          items: widget.question.options!
              .map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
          onChanged: (newValue) {
            setState(() {
              _currentSelection = newValue!;
            });
            _assessmentController.setAnswer(
              _assessmentController.currentQuestionIndex.value,
              newValue,
            );
          },
          value: _assessmentController
              .getAnswer(_assessmentController.currentQuestionIndex.value),
          hint: const Text('Select an option'),
        ),
      ),
    );
  }
}
