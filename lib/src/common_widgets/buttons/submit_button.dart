import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final double? userWidth;
   const SubmitButton({super.key, required this.label, required this.onTap, this.userWidth});

  

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final customWidth = userWidth ?? width * 0.54;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: customWidth,
        height: 46,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: const Color.fromARGB(247, 40, 56, 234),),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )),
        ),
      ),
    );
  }
}
