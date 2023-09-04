import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:const Color(0xFF4e5ae8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12),)),
        ),
      ),
    );
  }
}
