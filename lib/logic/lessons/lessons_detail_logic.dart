import 'package:classes/base/base_controller.dart';
import 'package:classes/http/lessons_api.dart';
import 'package:classes/model/lessons/check_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LessonsDetailLogic extends BaseLogic{
  final ScrollController scrollController = ScrollController();
  Check? _check;
  List<int> row = [];
  List<int> column = [];

  Check? get check => _check;

  Future getCheck(int infoId) async{
    _check = await LessonAPI.getCheck(Get.arguments);
    column = _check?.column?.split(",").map((e) => int.parse(e)).toList() ?? [];
    row = _check?.row?.split(",").map((e) => int.parse(e)).toList() ?? [];
    update();
  }
}