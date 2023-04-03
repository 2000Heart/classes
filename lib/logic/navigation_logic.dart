import 'package:classes/base/base_controller.dart';
import 'package:classes/http/api.dart';
import 'package:classes/http/home_api.dart';
import 'package:classes/pages/messages/messages_page.dart';
import 'package:classes/res//nav_icons.dart';
import 'package:classes/widgets/keep_alive.dart';
import 'package:flutter/material.dart';
import '../pages/home/home_page.dart';
import '../pages/lessons/lessons_page.dart';
import '../pages/mine/mine_page.dart';

class NavigationLogic extends BaseLogic{

  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex;
  List<Widget> get pageList => _pageList;

  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final List<Widget> _pageList = [
    KeepAliveWrapper(child: HomePage()),
    KeepAliveWrapper(child: LessonsPage()),
    KeepAliveWrapper(child: MessagesPage()),
    KeepAliveWrapper(child: MinePage())
  ];
  final List<IconData> icon = [NavIcons.home,NavIcons.lesson,NavIcons.messages,NavIcons.mine];
  final List<String> labelList = ["课程表","课程","消息","我的"];

  set currentIndex(value){
    _currentIndex = value;
    update();
  }
}