import 'package:classes/base/base_controller.dart';
import 'package:classes/http/home_api.dart';
import 'package:classes/http/message_api.dart';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/model/message_entity.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/utils.dart';
import 'package:flutter/cupertino.dart';

import '../../http/api.dart';
import '../../utils/sp_utils.dart';

class HomeAddLogic extends BaseLogic{
  int _timeCount = 1;
  String _lessonName = "";
  List<List<int>> _duration = [[1,SpUtils.tableSet?.totalWeek ?? 0]];
  List<int> _weekTime = [1];

  List<List<int>> _unit = [[1,1]];
  List<String> _teacher = [""];
  List<String> _classroom = [""];

  int get timeCount => _timeCount;
  List<List<int>> get duration => _duration;
  String get lessonName => _lessonName;
  List<String> get classroom => _classroom;
  List<String> get teacher => _teacher;
  List<List<int>> get unit => _unit;
  List<int> get weekTime => _weekTime;

  set weekTime(List<int> value) {
    _weekTime = value;
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
  set lessonName(String value) {
    _lessonName = value;
    update();
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

  void setDuration(index,value){
    _duration[index] = value;
    update();
  }

  void setUnit(index,List<int> value){
    _unit[index] = value;
    update();
  }

  Future createSchedule() async{
    List<Json> list = [];
    for(var i = 0;i<_timeCount;i++){
      if(!_lessonName.isNullOrEmpty) {
        Json need = Schedule(
            lessonName: _lessonName,
            userId: UserState.info?.userId.toString(),
            duration: _duration[i].join(","),
            weekTime: _weekTime[i],
            startUnit: _unit[i][0],
            endUnit: _unit[i][1],
            classroom: _classroom[i],
            teacherName: _teacher[i]
        ).toJson();
        need.removeWhere((key, value) => value == null);
        list.add(need);
      }
    }
    HomeAPI.createSchedule(list);

  }
}