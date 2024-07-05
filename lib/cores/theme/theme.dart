import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/theme/color_pellets.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 1));
  static final darkThemeMode = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
          backgroundColor: AppPallete.backgroundColor, centerTitle: true),
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: const Color.fromARGB(255, 50, 50, 50),
        textColor: Colors.white,
        iconColor: Colors.white,
        selectedColor: Colors.blue,
        selectedTileColor: Colors.blueAccent,
      ),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(27),
          border: _border(),
          focusedBorder: _border(AppPallete.gradient2),
          errorBorder: _border(AppPallete.errorColor),
          enabledBorder: _border()));

  static final lightThemeMode = ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
          backgroundColor: AppPallete.lightBackgroundColor, centerTitle: true),
      scaffoldBackgroundColor: AppPallete.lightBackgroundColor,
      drawerTheme: const DrawerThemeData(backgroundColor: Colors.grey),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: Colors.white,
        textColor: Colors.black,
        iconColor: Colors.black,
        selectedColor: Colors.blue,
        selectedTileColor: Colors.blueAccent,
      ),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(27),
          border: _border(),
          focusedBorder: _border(AppPallete.lightGradient2),
          errorBorder: _border(AppPallete.errorColor),
          enabledBorder: _border()));
}
