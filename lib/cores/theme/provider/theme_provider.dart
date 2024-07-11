import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/services/firebase_methods.dart';
import 'package:haash_moving_chart/cores/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkMode = true;
  ThemeData _themeData = AppTheme.darkThemeMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(value) {
    isDarkMode = value;
    if (isDarkMode == true) {
      themeData = AppTheme.darkThemeMode;
    } else {
      themeData = AppTheme.lightThemeMode;
    }
    isDarkModeChanged();
  }

  final FirebaseAuthMethods _firebaseAuthMethods =
      FirebaseAuthMethods(FirebaseAuth.instance);
  void isDarkModeChanged() async {
    try {
      await _firebaseAuthMethods.updateDarkModeTheme(isDarkMode);
    } catch (e) {
      rethrow;
    }
  }
}
