import 'package:classes/base/base_controller.dart';
import 'package:flutter/cupertino.dart';

class HomeLogic extends BaseLogic{
  final PageController pageController = PageController();

  int _currentIndex = 0;
  int _weekIndex = 1;
  int _tableIndex = 0;

  int get tableIndex => _tableIndex;
  int get currentIndex => _currentIndex;
  int get weekIndex => _weekIndex;

  set currentIndex(index) {
    _currentIndex = index;
    update();
  }
  set weekIndex(int value) {
    _weekIndex = value;
    update();
  }
  set tableIndex(int value) {
    _tableIndex = value;
    update();
  }


}