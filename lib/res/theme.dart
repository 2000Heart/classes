import 'package:flutter/material.dart';

class ThemeConfig{
  static ThemeData theme(){
    return ThemeData(
      primarySwatch: Colors.blue,
      appBarTheme: _appBarTheme(),
      splashColor: Colors.transparent,
      iconTheme: IconThemeData(size: 20),
      scaffoldBackgroundColor: Colors.white,
      highlightColor: Colors.transparent,
      textButtonTheme: TextButtonThemeData(style: ButtonStyle(
      overlayColor: MaterialStateProperty.resolveWith((states) {
        return Colors.transparent;
      })))
    );
  }

  static AppBarTheme _appBarTheme(){
    return const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      toolbarHeight: 44,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      )
    );
  }
}