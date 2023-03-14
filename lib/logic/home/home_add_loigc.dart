import 'package:classes/base/base_controller.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/sp_utils.dart';

class HomeAddLogic extends BaseLogic{
  int _timeCount = 1;
  ScrollController _controller = ScrollController();
  String _lessonName = "";
  List<List<int>> _duration = [[1,SpUtils.tableSet?.totalWeek ?? 0]];
  List<int> _weekTime = [1];

  List<List<int>> _unit = [[1,1]];
  List<String> _teacher = [""];
  List<String> _classroom = [""];

  int get timeCount => _timeCount;
  List<List<int>> get duration => _duration;
  ScrollController get controller => _controller;
  String get lessonName => _lessonName;
  List<String> get classroom => _classroom;
  List<String> get teacher => _teacher;
  List<List<int>> get unit => _unit;
  List<int> get weekTime => _weekTime;

  set weekTime(List<int> value) {
    _weekTime = value;
    update();
  }
  set unit(List<List<int>> value) {
    _unit = value;
    update();
  }
  set teacher(List<String> value) {
    _teacher = value;
    update();
  }

  set classroom(List<String> value) {
    _classroom = value;
    update();
  }
  set timeCount(int value) {
    _timeCount = value;
    update();
  }

  set controller(ScrollController value) {
    _controller = value;
    update();
  }

  set duration(List<List<int>> value) {
    _duration = value;
    update();
  }

  set lessonName(String value) {
    _lessonName = value;
  }

  @override
  void onInit() {
    super.onInit();
    controller.addListener(() {
      if(!controller.keepScrollOffset) {
        controller.jumpTo(controller.position.maxScrollExtent);
      }
    });
  }

  void add(){
    _duration.add([1,SpUtils.tableSet?.totalWeek ?? 0]);
    _weekTime.add(1);
    _unit.add([1,1]);
    _teacher.add("");
    _classroom.add("");
    update();
  }

  void remove(index){
    _duration.removeAt(index);
    _weekTime.removeAt(index);
    _unit.removeAt(index);
    _teacher.removeAt(index);
    _classroom.removeAt(index);
    update();
  }
}