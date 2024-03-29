import 'dart:io';

import 'package:classes/res/colours.dart';
import 'package:flutter/material.dart';

class Styles{
  static const LinearGradient SIGNUP_BACKGROUND = LinearGradient(
    begin: FractionalOffset(0.0, 0.4), end: FractionalOffset(0.9, 0.7),
    // Add one stop for each color. Stops should increase from 0 to 1
    stops: [0.1, 0.9], colors: [Colours.YELLOW, Colours.BLUE],
  );

  static const LinearGradient SIGNUP_CARD_BACKGROUND = LinearGradient(
    tileMode: TileMode.clamp,
    begin: FractionalOffset.centerLeft,
    end: FractionalOffset.centerRight,
    stops: [0.1, 1.0],
    colors: [Colours.SIGNUP_LIGHT_RED, Colours.SIGNUP_RED],
  );

  static const LinearGradient SIGNUP_CIRCLE_BUTTON_BACKGROUND = LinearGradient(
    tileMode: TileMode.clamp,
    begin: FractionalOffset.centerLeft,
    end: FractionalOffset.centerRight,
    // Add one stop for each color. Stops should increase from 0 to 1
    stops: [0.4, 1],
    colors: [Colors.black, Colors.black54],
  );

  static StrutStyle center(double fontSize, {FontWeight? fontWeight}) {
    return StrutStyle(
        fontSize: fontSize,
        height: Platform.isIOS ? 1.1 : 1.4,
        forceStrutHeight: true,
        fontWeight: fontWeight ?? FontWeight.w400);
  }
}