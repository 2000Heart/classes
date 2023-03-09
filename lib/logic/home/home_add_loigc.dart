import 'package:classes/base/base_controller.dart';
import 'package:flutter/cupertino.dart';
import '../../model/home/schedule_entity.dart';

class HomeAddLogic extends BaseLogic{
  int _timeCount = 1;
  ScrollController _controller = ScrollController();
  List<Schedule> _data = [Schedule()];

  int get timeCount => _timeCount;
  ScrollController get controller => _controller;
  List<Schedule> get data => _data;

  set timeCount(int value) {
    _timeCount = value;
    update();
  }

  set controller(ScrollController value) {
    _controller = value;
    update();
  }

  set data(List<Schedule> value) {
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