// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../controllers/assessment_controller.dart';
// import '../../models/assessment.dart';

// class DropDownList extends StatelessWidget {
//     final Question question;


      
//   DropDownList({super.key, required this.question});

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       items: question.options!
//           .map((option) => DropdownMenuItem(
//                 value: option,
//                 child: Text(option),
//               ))
//           .toList(),
//       onChanged: (value) {
//         assessmentController.setAnswer(
//           assessmentController.currentQuestionIndex.value,
//           value,
//         );
//       },
//       value: assessmentController.getAnswer(assessmentController.currentQuestionIndex.value),
//       hint: const Text('Select an option'),
//     );
//   }
// }

