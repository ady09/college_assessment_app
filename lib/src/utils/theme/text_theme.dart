import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextTheme {
  static TextTheme lightTheme = TextTheme(
      displayMedium: GoogleFonts.roboto(
        color: Colors.black87,
      ),
      titleSmall: GoogleFonts.poppins(
        color: Colors.black54,
        fontSize: 24,
      ));

  static TextTheme darkTheme = TextTheme(
      displayMedium: GoogleFonts.roboto(
        color: Colors.white70,
      ),
      titleSmall: GoogleFonts.poppins(
        color: Colors.white60,
        fontSize: 24,
      ));

  static TextTheme splashBold = TextTheme(
      displayMedium: GoogleFonts.roboto(
          color: Colors.black87, fontWeight: FontWeight.bold));

  static TextTheme splashLight = TextTheme(
      displaySmall: GoogleFonts.poppins(
          color: Colors.black54, fontWeight: FontWeight.normal));

  static TextStyle get subHeadingStyle {
    return GoogleFonts.lato(
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey));
  }

  static TextStyle get HeadingStyle {
    return GoogleFonts.lato(
        textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black));
  }

  static TextStyle get AppBarStyle {
    return GoogleFonts.lato(
        textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black));
  }

  static TextStyle get TitleStyle {
    return GoogleFonts.lato(
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black));
  }

  static TextStyle get subTitleStyle {
    return GoogleFonts.lato(
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey));
  }

  static TextStyle get medSubTitle {
    return GoogleFonts.lato(
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color.fromARGB(220, 0, 0, 0)));
  }

  static TextStyle get smContentTitle {
    return GoogleFonts.lato(
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromARGB(182, 0, 0, 0)));
  }

  static TextStyle get smContent {
    return GoogleFonts.lato(
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color.fromARGB(156, 0, 0, 0)));
  }

  static TextStyle get questionTitleStyle {
    return GoogleFonts.lato(
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color.fromARGB(205, 0, 0, 0)));
  }
}
