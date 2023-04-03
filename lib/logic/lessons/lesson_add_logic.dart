import 'dart:ffi';

import 'package:classes/http/data_api.dart';
import 'package:classes/http/lessons_api.dart';
import 'package:classes/model/data/class_entity.dart';
import 'package:classes/model/data/lesson_entity.dart';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/model/lessons/lesson_entity.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../base/base_controller.dart';
import '../../http/home_api.dart';
import '../../http/message_api.dart';
import '../../utils/sp_utils.dart';

class LessonAddLogic extends BaseLogic{
  int _timeCount = 1;
  List<Schedule> _data = [Schedule(
    teacherName: UserState.info?.userName,
    teacherId: "${UserState.info?.userId}"
  )];
  String _lessonName = "";

  List<ClassEntity> classes = [];
  int get timeCount => _timeCount;
  List<List<bool>> _classChoice = [[]];
  String get lessonName => _lessonName;
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
  set lessonName(String value) {
    _lessonName = value;
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
    classes = await DataAPI.getClassList() ?? [];
    _classChoice[0] = List.generate(classes.length, (index) => false);
    update();
  }

  Future create() async{
    LessonEntity? lessonEntity = await DataAPI.getLesson(_lessonName);
    List<Json> list = [];
    for(var i = 0;i<_data.length;i++){
      _data[i].lessonId = lessonEntity?.lessonId;
      _data[i].lessonName = _lessonName;
      if(!_data[i].lessonName.isNullOrEmpty) {
        List<String> stu = [];
        for (var e=0; e<classes.length; e++) {
          if(_classChoice[i][e]){
            stu.addAll(classes[e].userId?.split(',') ?? []);
          }
        }
        _data[i].userId = stu.join(',');
        stu = [];
        var need = _data[i].toJson();
        need.removeWhere((key, value) => value == null);
        list.add(need);
      }
    }
    List<Schedule> schedules = await HomeAPI.createSchedule(list);
    var lesson = Lesson(
      lessonId: lessonEntity?.lessonId,
      lessonName: _lessonName,
      teacherId: "${UserState.info?.userId}",
      teacherName: "${UserState.info?.userName}",
      eventId: schedules.map((e) => e.eventId).toList().join(","),
      schoolName: UserState.info?.school,
      duration: _data.map((e) => e.duration).toSet().join(',')
    ).toJson();
    Lesson? back = await LessonAPI.createLesson(lesson);
    if(back != null) {
      MessageAPI.createMessage(
      userAll: schedules.map((e) => e.userId).toSet().join(','),
      title: _lessonName,
      content: "教师${UserState.info?.userName}创建了本课程，您已被加入，前往课程页面查看详情",
      type: 0
      );
      MessageAPI.createMessage(
          userAll: UserState.info?.userId.toString() ?? "",
          title: _lessonName,
          content: "您创建了本课程，前往课程页面查看详情",
          type: 0
      );
    }
  }
}