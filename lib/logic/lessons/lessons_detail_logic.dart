import 'package:classes/base/base_controller.dart';
import 'package:classes/http/lessons_api.dart';
import 'package:classes/model/lessons/check_entity.dart';
import 'package:classes/model/lessons/lesson_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../states/user_state.dart';

class LessonsDetailLogic extends BaseLogic{
  final ScrollController scrollController = ScrollController();
  Check? _check;
  Lesson? data = Get.arguments;
  List<int> row = [];
  List<int> column = [];
  List<String> signMember = [];

  Check? get check => _check;

  @override
  void onReady() {
    getCheck();
  }

  Future getCheck() async{
    _check = await LessonAPI.getCheck(data?.infoId ?? 0);
    column = _check?.column?.split(",").map((e) => int.parse(e)).toList() ?? [];
    row = _check?.row?.split(",").map((e) => int.parse(e)).toList() ?? [];
    for(var i=0;i<column.length;i++){
      for(var j=0;j<column.length;j++){
        signMember.add(" ");
      }
    }
    update();
  }

  Future updateCheck(int index) async{
    signMember[index] = UserState.info?.userName ?? "";
    var i = await LessonAPI.updateCheck(_check?.checkId ?? 0, signMember.join(','));
    if(i > 0) getCheck();
  }
}