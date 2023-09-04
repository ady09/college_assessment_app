import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const SubmitButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 124,
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:const Color(0xFF4e5ae8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16),)),
        ),
      ),
    );
  }
}
