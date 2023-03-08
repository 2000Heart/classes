import 'dart:math';

import 'package:classes/base/base_controller.dart';

class MyClassLogic extends BaseLogic{
  List<String> classes = List.generate(7, (index) => "物联网19${index+1}");
  List<String> stu = List.generate(15, (index) => "$index"*Random.secure().nextInt(4));
  int? _currentIndex;

  int? get currentIndex => _currentIndex;

  set currentIndex(int? value) {
    _currentIndex = value;
    update();
  }
}