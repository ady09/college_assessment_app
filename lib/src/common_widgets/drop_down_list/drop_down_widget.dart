import 'package:college_assessment_app/src/features/authentication/controllers/assessment_controller.dart';
import 'package:college_assessment_app/src/features/authentication/models/assessment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownWidget extends StatefulWidget {
  DropDownWidget({super.key, required this.question});

  final Question question;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  final AssessmentController _assessmentController = Get.find();
  // ignore: unused_field
  String? _currentSelection;

  @override
  void initState() {
    super.initState();
    // Initialize _currentSelection with the current answer
    _currentSelection = "Please Select an option";
  }

  // _assessmentController
  //       .getAnswer(_assessmentController.currentQuestionIndex.value);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(12)),
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
          value: _currentSelection,
          hint: const Text('Select an option'),
        ),
      ),
    );
  }
}
