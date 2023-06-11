import 'dart:ui';

class Colours{
  static const Color white = Color(0xFFFFFCFC);
  static const Color blue1 = Color(0xFFc0c9d5);
  static const Color green1 = Color(0xFFb3c2af);
  static const Color grey = Color(0xFF999999);
  static const Color grey1 = Color(0xFFe0e4de);
  static const Color grey2 = Color(0xFFd6d6d6);
  static const Color grey3 = Color(0xFFded6d6);
  static const Color grey4 = Color(0xFFc9c9c9);
  static const Color grey5 = Color(0xFFf7f1f0);

  static const Color yellow1 = Color(0xFFe4dfce);
  static const Color cyan1 = Color(0xFFcddee0);
  static const Color red1 = Color(0xFFe3cece);

  static const MAIN_COLOR = Color(0xFF303030);
  static const DARK_COLOR = Color(0xFFBDBDBD);
  static const BOTTOM_COLORS = [MAIN_COLOR, DARK_COLOR];
  static const YELLOW = Color(0xfffbed96);
  static const BLUE = Color(0xffabecd6);
  static const BLUE_DEEP = Color(0xffA8CBFD);
  static const BLUE_LIGHT = Color(0xffAED3EA);
  static const PURPLE = Color(0xffccc3fc);
  static const SIGNUP_LIGHT_RED = Color(0xffffc2a1);
  static const SIGNUP_RED = Color(0xffffb1bb);
  static const RED = Color(0xffF2A7B3);
  static const PINK = Color(0xfff5d3c3);
  static const GREEN = Color(0xffc7e5b4);
  static const GREEN1 = Color(0xFFACCAC1);
  static const RED_LIGHT = Color(0xffFFC3A0);
  static const TEXT_BLACK = Color(0xFF353535);
  static const TEXT_BLACK_LIGHT = Color(0xFF34323D);

  static const List<Color> colorList = [
    YELLOW,GREEN,BLUE_DEEP,BLUE_LIGHT,BLUE,PURPLE,SIGNUP_LIGHT_RED,SIGNUP_RED,RED,RED_LIGHT
  ];

  static const List<List<Color>> navigationColors = [
    [RED_LIGHT,GREEN],[YELLOW,RED],[PURPLE,BLUE_LIGHT],[SIGNUP_LIGHT_RED,BLUE_DEEP]
  ];
}