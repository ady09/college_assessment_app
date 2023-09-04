import 'package:college_assessment_app/src/utils/theme/text_theme.dart';

import 'package:flutter/material.dart';

class HeaderContainerWidget extends StatelessWidget {
  const HeaderContainerWidget({super.key, required this.curriculumText, required this.curriculumTextContent});

  final String curriculumText;
  final String curriculumTextContent;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.16,
      width: width * 1,
      decoration: BoxDecoration(
          color: const Color.fromARGB(42, 235, 193, 23),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*0.008,),
               Text(curriculumText, style: CustomTextTheme.smContentTitle),
               SizedBox(height: height*0.012,),
               Text(curriculumTextContent, style: CustomTextTheme.smContent)
            ],
          ),
        ),
      )
    );
  }
}
