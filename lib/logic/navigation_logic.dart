import 'package:classes/base/base_controller.dart';
import 'package:classes/http/api.dart';
import 'package:classes/pages/messages/messages_page.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/sp_utils.dart';
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
  final PageController _pageController = PageController();
  final List<Widget> _pageList = [
    KeepAliveWrapper(child: HomePage()),
    KeepAliveWrapper(child: LessonsPage()),
    KeepAliveWrapper(child: MessagesPage()),
    KeepAliveWrapper(child: MinePage())
  ];
  final List<IconData> icon = [Icons.add,Icons.ac_unit,Icons.message,Icons.accessibility];
  final List<String> labelList = ["课程表","课程","消息","我的"];

  void setIndex(value){
    _currentIndex = value;
    update();
  }

  @override
  void onInit() async{
    super.onInit();
    if(UserState.info != null) SpUtils.tableSet = await Api.getTableSet(UserState.info?.userId);
  }
}