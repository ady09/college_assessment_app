import 'package:college_assessment_app/src/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  final Widget? widget;

  const InputField(
      {super.key,
      required this.title,
      
      required this.hint, this.controller, this.widget, required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: const EdgeInsets.only(top: 16.0),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
          style: CustomTextTheme.TitleStyle,),
          Container(
            margin: EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 14),
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  keyboardType: keyboardType,
                  autofocus: false,
                  cursorColor: Colors.grey,
                  controller: controller,
                  style: CustomTextTheme.subTitleStyle,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: CustomTextTheme.subTitleStyle,
                    focusedBorder:const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0
                      )
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0
                      )
                    ),
                  ),
                ))
              ],
            ),
            
          )
        ],
      ),
    );
  }
}
