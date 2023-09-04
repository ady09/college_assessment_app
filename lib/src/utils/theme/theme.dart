import 'package:college_assessment_app/src/utils/theme/text_theme.dart';
import 'package:college_assessment_app/src/utils/theme/themes_widget/elevated_button.dart';
import 'package:flutter/material.dart';

class CustomTheme {

  CustomTheme._();

  static ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  
  textTheme: CustomTextTheme.lightTheme,
  elevatedButtonTheme: CustomElevatedButtonTheme.blueElevatedButtonTheme);


  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.light,
    
    textTheme: CustomTextTheme.darkTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.blueElevatedButtonTheme);
}