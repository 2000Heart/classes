import 'package:classes/base/base_controller.dart';
import 'package:flutter/cupertino.dart';

class HomeLogic extends BaseLogic{
  final PageController pageController = PageController();
  int currentIndex = 0;

  void setIndex(index) {
    currentIndex = index;
    update();
  }
}