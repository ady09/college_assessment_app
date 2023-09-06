import 'package:flutter/material.dart';

class AssessmentContainerWidget extends StatelessWidget {
  const AssessmentContainerWidget({super.key, this.widget});

  final Widget? widget;
  

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
      child: widget,
    );
  }
}
