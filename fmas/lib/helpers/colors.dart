import 'package:flutter/material.dart';

class AppColor {
  static const Color primaryColor = Color(0xFF6151C4);
  static const Color complimentColor = Color(0xFF9587E9);
  static const Color cardColor = Color(0xFFEFEEF9);
  static const Color textFieldColor = Color(0xFFD5D6EF);
  static const Color emergencyColor = Color(0xFFEC0E0E);
  static const Color dangerFloodColor = Color(0xFFEC4A4A);
  static const Color warningFloodColor = Color(0xFFFAB54F);
  static const Color greenFloodColor = Color(0xFF6DDE51);
  static const Color textColor = Color(0xFF000000);
  static const Color disbledButtonColor = Color(0xFFD3D2D2);
  static const MaterialColor customPrimaryColor = MaterialColor(
    0xFF6151C4,
    <int, Color>{
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    },
  );
}
