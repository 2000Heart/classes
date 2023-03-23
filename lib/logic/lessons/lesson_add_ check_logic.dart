import 'package:classes/base/base_controller.dart';
import 'package:classes/http/data_api.dart';
import 'package:classes/model/data/classroom.dart';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/model/lessons/check_entity.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/sp_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../http/lessons_api.dart';
import '../../http/message_api.dart';
import '../../model/lessons/lesson_entity.dart';
import '../../utils/utils.dart';

class LessonAddCheckLogic extends BaseLogic{
  int _timeCount = 1;
  List<Schedule>? _schedule;
  List<String> _itemList = [];
  int? _choice;
  List<DateTime> _daysList = [];
  DateTime? _startTime;
  DateTime? _endTime;

  List<DateTime> get daysList => _daysList;
  DateTime? get startTime => _startTime;
  DateTime? get endTime => _endTime;
  int? get choice => _choice;
  List<String> get itemList => _itemList;
  List<Schedule> get schedule => _schedule ?? [];
  int get timeCount => _timeCount;

  set timeCount(int value) {
    _timeCount = value;
    update();
  }
  set choice(int? value) {
    _choice = value;
    update();
  }
  set endTime(DateTime? value) {
    _endTime = value;
    update();
  }
  set startTime(DateTime? value) {
    _startTime = value;
    update();
  }

  @override
  void onReady() {
    requestData();
  }

  Future requestData() async{
    _schedule = await LessonAPI.getLessonSchedule(Get.arguments);
    _itemList = List.generate(_schedule?.length ?? 0, (index) => formUnit(index));
    update();
  }

  String formUnit(int index){
    return "周${weekZh(_schedule?[index].weekTime ?? 0)} ${_schedule?[index].startUnit}-${_schedule?[index].endUnit}节";
  }

  Future createCheck() async{
    if(_choice != null) {
      Classroom? classroom = await DataAPI.getClassroom(_schedule?[_choice!].classroom ?? "");
      Json check = Check(
        infoId: Get.arguments,
        lessonName: _schedule?[_choice!].lessonName,
        userAll: _schedule?[_choice!].userId,
        startTime: _startTime?.toIso8601String(),
        endTime: _endTime?.toIso8601String(),
        postTime: DateTime.now().toIso8601String(),
        column: classroom?.column,
        row: classroom?.row,
        teacherId: UserState.info?.userId,
        teacherName: UserState.info?.userName
      ).toJson();
      Check? back = await LessonAPI.createCheck(check);
      if(back!=null){
        MessageAPI.createMessage(
            userAll: _schedule?[_choice!].userId ?? "",
            title: _schedule?[_choice!].lessonName ?? "",
            type: 1
        );
      }
    }
  }

  void formDays(){
    _daysList.clear();
    var year = DateTime.now().year;
    var month = DateTime.now().month;
    var day = DateTime.now().day;
    var length = DateTime(year,month+1,0).day;
    for(var i=day;i<=length;i++){
      var time = DateTime(year,month,i);
      if(time.weekday == _schedule?[_choice!].weekTime){
        _daysList.add(time);
      }
    }
    update();
  }


}