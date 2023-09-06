import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          width: 160,
          height: 60,
          
          decoration: BoxDecoration(
            border: Border.all(width: 0, color:Colors.transparent),
            borderRadius: BorderRadius.circular(20),
            // color:const Color(0xFF4e5ae8),
            color: Colors.transparent
            
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Row(
              children: [
                const Icon(Icons.add_box),
                const SizedBox(width: 8,),
                Text(label, style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
