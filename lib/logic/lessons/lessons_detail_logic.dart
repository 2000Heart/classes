import 'package:classes/base/base_controller.dart';
import 'package:classes/http/lessons_api.dart';
import 'package:classes/model/lessons/check_entity.dart';
import 'package:classes/model/lessons/lesson_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LessonsDetailLogic extends BaseLogic{
  final ScrollController scrollController = ScrollController();
  Check? _check;
  Lesson? data = Get.arguments;
  List<int> row = [];
  List<int> column = [];
  List<List<String>> signMember = [];

  Check? get check => _check;

  Future getCheck() async{
    _check = await LessonAPI.getCheck(data?.infoId ?? 0);
    column = _check?.column?.split(",").map((e) => int.parse(e)).toList() ?? [];
    row = _check?.row?.split(",").map((e) => int.parse(e)).toList() ?? [];
    signMember = List.generate(column.length, (index) => List.generate(column[index]*row[index],(index) => ""));
    update();
  }
}