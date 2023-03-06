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
    return AppBarTheme(
      centerTitle: true,
      elevation: 5,
      toolbarHeight: 44,
      backgroundColor: Colors.white,
      actionsIconTheme: IconThemeData(size: 30,color: Colors.black.withOpacity(0.65)),
      titleTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      )
    );
  }
}