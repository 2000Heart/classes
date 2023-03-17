import 'package:classes/base/base_controller.dart';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/model/lessons/check_entity.dart';
import 'package:classes/states/user_state.dart';
import 'package:flutter/cupertino.dart';

import '../../http/lessons_api.dart';
import '../../model/lessons/lesson_entity.dart';

class LessonAddCheckLogic extends BaseLogic{
  int _timeCount = 1;
  ScrollController _controller = ScrollController();
  Check _data = Check();
  final TextEditingController _editingController = TextEditingController();
  List<String> roomList = ["2308","4441","5111","2115","2117","3412"];
  List<String> reRoomList = [];
  List<String> classList = [];
  bool _choice = true;
  late FocusNode focus;
  String _input = '';
  List<Lesson>? _lessons;
  
  Check get data => _data;
  List<Lesson> get lessons => _lessons ?? [];
  bool get choice => _choice;
  String get input => _input;
  TextEditingController get editingController => _editingController;
  int get timeCount => _timeCount;
  ScrollController get controller => _controller;

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

  @override
  void onInit() {
    super.onInit();
    controller.addListener(() {
      if(!controller.keepScrollOffset) {
        controller.jumpTo(controller.position.maxScrollExtent);
      }
    });
  }

  Future getInput(str) async{
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

  Future requestData() async{
    _lessons = await LessonAPI.getLessonList();
    update();
  }
}