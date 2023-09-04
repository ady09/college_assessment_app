import 'package:flutter/material.dart';

class CustomElevatedButtonTheme {
  CustomElevatedButtonTheme._();

  static final blueElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(26))),
      backgroundColor: Color(0xFF4743FF),
      foregroundColor: Colors.white,
      
      padding: const EdgeInsets.symmetric(vertical: 15)
  ));
}
