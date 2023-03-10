import 'package:classes/base/base_controller.dart';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/states/user_state.dart';
import 'package:flutter/cupertino.dart';

import '../../http/api.dart';

class HomeLogic extends BaseLogic{
  final PageController pageController = PageController();

  int _currentIndex = UserState.tableSet?.currentWeek ?? 0;
  int _weekIndex = 1 + (UserState.tableSet?.currentWeek ?? 0);
  int _tableIndex = 0;
  List<Schedule>? data;
  List<List<List<Schedule>>> weekSchedule = List.generate(UserState.tableSet?.totalWeek ?? 0,(index) => List.generate(7, (index) => []));

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

  Future requestData() async{
    data = await Api.getScheduleList();
    if(data != null) {
      for (var i = 0; i < 18; i++) {
        for (var element in data!) {
          if(element.duration?.split(",").every((element) => int.parse(element) - (i + 1) == 0) == true){
            weekSchedule[i][element.weekTime! - 1].add(element);
          }
        }
      }
    }
  }

}