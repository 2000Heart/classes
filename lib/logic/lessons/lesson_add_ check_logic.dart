import 'package:classes/base/base_controller.dart';
import 'package:classes/model/home/home_class_single_day_entity.dart';
import 'package:flutter/cupertino.dart';

class LessonAddCheckLogic extends BaseLogic{
  int _timeCount = 1;
  ScrollController _controller = ScrollController();
  List<HomeClassSingeDayEntity> _data = [HomeClassSingeDayEntity()];
  final TextEditingController _editingController = TextEditingController();
  List<String> classList = [];
  bool _choice = true;
  late FocusNode focus;
  String _input = '';

  bool get choice => _choice;
  String get input => _input;
  TextEditingController get editingController => _editingController;
  int get timeCount => _timeCount;
  ScrollController get controller => _controller;
  List<HomeClassSingeDayEntity> get data => _data;

  set choice(bool value) {
    _choice = value;
  }


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

  Future getInput(str) async{
    _input = str;
    // classList.clear();
    // if(_input != ''){
    //   for (var element in classList) {
    //     if(element.expertName?.contains(RegExp(str,caseSensitive: false)) == true){
    //       classList.add(element);
    //     }
    //   }
    // }
    update();
  }
}