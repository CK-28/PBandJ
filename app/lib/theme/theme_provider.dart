import 'package:flutter/material.dart';
import 'package:app/theme/LightTheme.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  ThemeData _theme = lightTheme();

  ThemeData get themeData => _theme;

  void toggleTheme() {
    _isDark = !_isDark;
    if (_isDark) {
      _theme = ThemeData.dark();
    } else {
      _theme = lightTheme();
    }
    //print(_isDark);
    notifyListeners();
  }
}
