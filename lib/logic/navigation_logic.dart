import 'package:classes/base/base_controller.dart';
import 'package:flutter/material.dart';

import '../pages/home/home_page.dart';
import '../pages/lessons/lessons_page.dart';
import '../pages/mine/mine_page.dart';

class NavigationLogic extends BaseController{

  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex;
  List<Widget> get pageList => _pageList;

  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _pageList = [
    HomePage(),
    LessonsPage(),
    MinePage()
  ];
  final List<IconData> icon = [Icons.add,Icons.ac_unit,Icons.accessibility];
  final List<String> labelList = ["首页","课程","我的"];

  setIndex(value){
    _currentIndex = value;
    update();
  }
}