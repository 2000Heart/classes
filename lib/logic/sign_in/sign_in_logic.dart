import 'package:classes/base/base_controller.dart';
import 'package:classes/http/api.dart';
import 'package:classes/model/home/table_set.dart';
import 'package:classes/model/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:classes/http/home_api.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../../model/data/school_entity.dart';
import '../../res/routes.dart';
import '../../utils/sp_utils.dart';

class SignInLogic extends BaseLogic{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  get textEditingController => _textEditingController;
  late TextEditingController textController;
  final data = ["aaaaa", "cajnfoa", "hhokgo","string"];
  final LiquidController liquidController = LiquidController();
  bool _isLogin = true;
  User? user;
  TableSet? table;
  List<School>? _schoolList;
  List<School>? _classList;

  bool get isLogin => _isLogin;
  get formKey => _formKey;
  List<School> get schoolList => _schoolList ?? [];
  List<School> get classList => _classList ?? [];
  String _school = "";
  String _username = "";
  String _password = "";
  String _classInfo = "";
  int _userType = 0;

  int get userType => _userType;
  String get classInfo => _classInfo;
  String get school => _school;
  String get username => _username;
  String get password => _password;

  set school(String value) {
    _school = value;
    update();
  }
  set username(String value) {
    _username = value;
    update();
  }
  set password(String value) {
    _password = value;
    update();
  }

  set classInfo(String value) {
    _classInfo = value;
    update();
  }

  set userType(int value) {
    _userType = value;
    update();
  }

  set schoolList(List<School>? value) {
    _schoolList = value;
    update();
  }

  set classList(List<School>? value) {
    _schoolList = value;
    update();
  }

  set isLogin(bool value) {
    _isLogin = value;
    update();
  }

  validateID(value) {
    RegExp reg = RegExp(r'^\d{10}$');
    if (!reg.hasMatch(value)) {
      return '请输入10位学号';
    }
  }

  Future checkLogin() async{
    user = await Api.login(_username, _password);
    table = await HomeAPI.getTableSet(user?.userId);
    SpUtils.loginAuth = user;
    SpUtils.tableSet = table;
    update();
  }

  Future createUser() async{
    user = await Api.createUser(_username, _password, _school, _classInfo);
    table = await HomeAPI.getTableSet(user?.userId);
    SpUtils.loginAuth = user;
    SpUtils.tableSet = table;
    update();
  }
}