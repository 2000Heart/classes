import 'dart:async';
import 'dart:developer';

import 'package:classes/base/base_controller.dart';
import 'package:classes/http/lessons_api.dart';
import 'package:classes/model/lessons/check_entity.dart';
import 'package:classes/model/lessons/check_stu_entity.dart';
import 'package:classes/model/lessons/lesson_entity.dart';
import 'package:classes/utils/sp_utils.dart';
import 'package:classes/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../states/user_state.dart';

class LessonsDetailLogic extends BaseLogic{
  final ScrollController scrollController = ScrollController();
  Check? _check;
  Lesson? data = Get.arguments;
  int _count = 0;

  int get count => _count;

  set count(int value) {
    _count = value;
    update();
  }

  List<int> row = [];
  List<int> column = [];
  DateTime timeNow = DateTime.now();
  int status = 2;
  String text = "";
  List<CheckStu> _checkList = [];
  List<String> signMember = [];


  List<CheckStu> get checkList => _checkList;
  Check? get check => _check;

  Future getCheck() async{
    _check = await LessonAPI.getCheck(data?.infoId ?? 0);
    _checkList = await LessonAPI.getCheckStu(_check?.checkId ?? 0);
    column = _check?.column?.split(",").map((e) => int.parse(e)).toList() ?? [];
    row = _check?.row?.split(",").map((e) => int.parse(e)).toList() ?? [];
    var length = 0;
    for(var i=0; i<column.length;i++){
      length+=column[i]*row[i];
    }
    signMember = List.generate(length, (index) {
      var i=_checkList.indexWhere((element) => element.index == index);
      return i==-1?" ":_checkList[i].userName ?? "";
    });
    update();
  }

  @override
  void onInit() {
    super.onInit();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(_check != null) {
        var start = DateTime.parse(_check!.startTime!);
        var end = DateTime.parse(_check!.endTime!);
        timeNow = DateTime.now();
        if (timeNow.isAfter(start) && timeNow.isBefore(end)) {
          status = 0;
          var time = end.difference(timeNow).inMilliseconds;
          text = "距离结束：${DateFormat("HH小时mm分钟ss秒").format(
            DateTime.fromMillisecondsSinceEpoch(time,isUtc: true))}";
        } else if (timeNow.isBefore(start) && timeNow.difference(start).inDays < 1) {
          status = 1;
          var time = start.difference(timeNow).inMilliseconds;
          text = "距离开始：${DateFormat("HH小时mm分钟ss秒").format(
              DateTime.fromMillisecondsSinceEpoch(time,isUtc: true))}";
        } else {
          status = 2;
          text = "";
        }
        update();
      }
    });
  }

  Future updateCheck(int index, int? change) async{
    if(change==null) {
      Json stu = CheckStu(
          index: index,
          userId: UserState.info?.userId,
          userName: UserState.info?.userName,
          checkId: _check?.checkId
      ).toJson();
      stu.removeWhere((key, value) => value == null);
      await LessonAPI.createCheckStu(stu);
    }else{
      await LessonAPI.updateCheckStu(_checkList[change].id!,index);
    }
    getCheck();
  }

  Future deleteCheck(int index) async{
    await LessonAPI.deleteCheckStu(checkList[index].id ?? 0);
    getCheck();
  }

  void remove(int index){
    signMember.replaceRange(index, index+1, ["*"]);
    update();
  }
}