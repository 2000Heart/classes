import 'dart:math';

import 'package:classes/base/base_controller.dart';
import 'package:classes/http/data_api.dart';
import 'package:classes/model/data/class_entity.dart';

class MyClassLogic extends BaseLogic{
  List<String> classes = List.generate(7, (index) => "物联网19${index+1}");
  List<String> stu = List.generate(15, (index) => "$index"*Random.secure().nextInt(4));
  List<ClassEntity> _classList = [];
  int? _currentIndex;

  int? get currentIndex => _currentIndex;
  List<ClassEntity> get classList => _classList;

  set currentIndex(int? value) {
    _currentIndex = value;
    update();
  }

  void requestData() async{
    _classList = await DataAPI.getClassList() ?? [];
    update();
  }
}