import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkMode = false;
  ThemeData _themeData = AppTheme.lightThemeMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    if (isDarkMode == true) {
      themeData = AppTheme.darkThemeMode;
    } else {
      themeData = AppTheme.lightThemeMode;
    }
  }
}
