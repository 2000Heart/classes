import 'dart:ffi';

import 'package:classes/model/home/schedule_entity.dart';
import 'package:flutter/material.dart';

import '../../base/base_controller.dart';

class LessonAddLogic extends BaseLogic{
  int _timeCount = 1;
  ScrollController _controller = ScrollController();
  List<Schedule> _data = [Schedule()];
  final TextEditingController _editingController = TextEditingController();
  List<String> roomList = ["2308","4441","5111","2115","2117","3412"];
  List<String> reRoomList = [];
  List<int> classList = [];
  bool _choice = true;
  late FocusNode focus;
  String _input = '';

  bool get choice => _choice;
  String get input => _input;
  TextEditingController get editingController => _editingController;
  int get timeCount => _timeCount;
  ScrollController get controller => _controller;
  List<Schedule> get data => _data;

  set choice(bool value) {
    _choice = value;
    update();
  }


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

  void getInput(str) {
    _input = str;
    reRoomList.clear();
    if(_input != ''){
      for (var element in roomList) {
        if(element.contains(RegExp(_input,caseSensitive: false)) == true){
          reRoomList.add(element);
        }
      }
    }
    update();
  }
}