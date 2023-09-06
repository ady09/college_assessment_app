import 'package:flutter/material.dart';

class AssessmentButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final Icon? icon;
  final double width;


   const AssessmentButton(
      {super.key,
      required this.label,
      required this.onTap,
      this.icon, required this.width, });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: width,
          height: 40,
          
          decoration: BoxDecoration(
            
            borderRadius: BorderRadius.circular(10),
            // color: Color.fromARGB(247, 40, 56, 234),
            color: Colors.black
          ),
          child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: icon,
                    ),
                    Text(
                      label,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ))),
    );
  }
}
