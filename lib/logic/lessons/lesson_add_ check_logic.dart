import 'package:classes/base/base_controller.dart';
import 'package:classes/http/data_api.dart';
import 'package:classes/model/data/classroom.dart';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/model/lessons/check_entity.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/sp_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../http/lessons_api.dart';
import '../../model/lessons/lesson_entity.dart';
import '../../utils/utils.dart';

class LessonAddCheckLogic extends BaseLogic{
  int _timeCount = 1;
  Check _data = Check();
  List<Schedule>? _schedule;
  List<String> _itemList = [];
  int? _choice;
  String? _startTime;
  String? _endTime;

  String? get startTime => _startTime;
  String? get endTime => _endTime;
  int? get choice => _choice;
  List<String> get itemList => _itemList;
  Check get data => _data;
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
  set endTime(String? value) {
    _endTime = value;
    update();
  }
  set startTime(String? value) {
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
      Classroom classroom = await DataAPI.getClassroomList();
      Json check = Check(
        lessonId: _schedule?[_choice!].lessonId,
        userAll: _schedule?[_choice!].userId,
        startTime: _startTime,
        endTime: _endTime,
        postTime: DateTime.now().toIso8601String(),
        column: classroom.column,
        row: classroom.row,
        teacherId: UserState.info?.userId
      ).toJson();
      await LessonAPI.createCheck(check);
    }
  }
}