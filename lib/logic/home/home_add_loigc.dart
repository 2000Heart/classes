import 'package:classes/base/base_controller.dart';
import 'package:classes/model/home/home_class_single_day_entity.dart';
import 'package:flutter/cupertino.dart';

class HomeAddLogic extends BaseLogic{
  int _timeCount = 1;
  ScrollController _controller = ScrollController();
  List<HomeClassSingeDayEntity> _data = [HomeClassSingeDayEntity()];

  int get timeCount => _timeCount;
  ScrollController get controller => _controller;
  List<HomeClassSingeDayEntity> get data => _data;

  set timeCount(int value) {
    _timeCount = value;
    update();
  }

  set controller(ScrollController value) {
    _controller = value;
    update();
  }

  set data(List<HomeClassSingeDayEntity> value) {
    _data = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    controller.addListener(() {
      if(!controller.keepScrollOffset) {
        controller.jumpTo(controller.position.maxScrollExtent);
      }
    });
  }
}