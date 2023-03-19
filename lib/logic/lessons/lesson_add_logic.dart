import 'dart:ffi';

import 'package:classes/http/data_api.dart';
import 'package:classes/http/lessons_api.dart';
import 'package:classes/model/data/class_entity.dart';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/model/lessons/lesson_entity.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../base/base_controller.dart';
import '../../http/home_api.dart';
import '../../utils/sp_utils.dart';

class LessonAddLogic extends BaseLogic{
  int _timeCount = 1;
  List<Schedule> _data = [Schedule(
    teacherName: UserState.info?.userName,
    teacherId: "${UserState.info?.userId}"
  )];
  List<ClassEntity> classes = [];
  int get timeCount => _timeCount;
  List<List<bool>> _classChoice = [[]];

  List<List<bool>> get classChoice => _classChoice;
  List<Schedule> get data => _data;

  set choice(int value) {
    _classChoice[_timeCount-1][value] = !_classChoice[_timeCount-1][value];
    update();
  }
  set data(List<Schedule> value) {
    _data = value;
    update();
  }
  void add(){
    _timeCount += 1;
    _data.add(_data[timeCount-2]);
    _classChoice.add(List.generate(classes.length, (index) => false));
    update();
  }
  void remove(int index){
    _timeCount -= 1;
    _data.removeAt(index);
    _classChoice.removeAt(index);
    update();
  }
  void lessonName(int index,String value) {
    _data[index].lessonName = value;
    update();
  }
  void duration(int index,String value) {
    _data[index].duration = value;
    update();
  }
  void time(int index,List<int> value) {
    _data[index].weekTime = value[0];
    _data[index].startUnit = value[1];
    _data[index].endUnit = value[2];
    update();
  }
  void classroom(int index,String value) {
    _data[index].classroom = value;
    update();
  }
  void teacherName(int index,String value) {
    _data[index].teacherName = value;
    update();
  }
  void students(int index,String value){
    _data[index].userId = value;
    update();
  }

@override
  void onReady() {
    requestData();
  }

  Future requestData() async{
    classes = await DataAPI.getClassList();
    _classChoice[0] = List.generate(classes.length, (index) => false);
    update();
  }

  Future create() async{
    var lessonId = await DataAPI.getLesson(_data[0].lessonName ?? "");
    List<Json> list = [];
    for(var i = 0;i<_data.length;i++){
      _data[i].lessonId = lessonId;
      if(!_data[i].lessonName.isNullOrEmpty) {
        var stu = "";
        for (var e=0; e<classes.length; e++) {
          if(_classChoice[i][e]){
            stu += classes[e].userId ?? '';
          }
        }
        _data[i].userId = stu;
        stu = '';
        var need = _data[i].toJson();
        need.removeWhere((key, value) => value == null);
        list.add(need);
      }
    }
    List<Schedule> schedules = await HomeAPI.createSchedule(list);
    var lesson = Lesson(
      lessonId: lessonId,
      lessonName: _data[0].lessonName,
      eventId: schedules.map((e) => e.eventId).toList().join(",")
    ).toJson();
    lesson.removeWhere((key, value) => value == null);
    LessonAPI.createLesson(lesson);
  }
}