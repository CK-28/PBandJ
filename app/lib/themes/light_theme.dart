import 'package:flutter/material.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
      primaryColor: Color(0xFFEC4686),
      primaryColorLight: Color(0xFF9CEAEF),
      primaryColorDark: Color(0xFFCE9164),
      cardColor: Colors.white,
      scaffoldBackgroundColor: Color(0xFFF8D5BC),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Color(0xFFEC4686)),
      appBarTheme: AppBarTheme(backgroundColor: Color(0xFF875632)));
}
