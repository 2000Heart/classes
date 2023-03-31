import 'dart:developer';

import 'package:classes/base/base_controller.dart';
import 'package:classes/http/api.dart';
import 'package:classes/http/data_api.dart';
import 'package:classes/model/data/class_entity.dart';
import 'package:classes/model/home/table_set.dart';
import 'package:classes/model/user_entity.dart';
import 'package:classes/http/home_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import '../../model/data/school_entity.dart';
import '../../utils/sp_utils.dart';

class SignInLogic extends BaseLogic{
  final LiquidController liquidController = LiquidController();
  final nameController = TextEditingController();
  final schoolController = TextEditingController();
  final classController = TextEditingController();
  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLogin = false;
  int _index = 0;
  User? user;
  TableSet? table;
  List<School>? _schoolList;
  List<ClassEntity>? _classList;

  int get index => _index;
  bool get isLogin => _isLogin;
  List<School> get schoolList => _schoolList ?? [];
  List<ClassEntity> get classList => _classList ?? [];
  String _school = "";
  String _account = "";
  String _username = "";
  String _password = "";
  String _classInfo = "";
  int _userType = 0;

  int get userType => _userType;
  String get classInfo => _classInfo;
  String get school => _school;
  String get account => _account;
  String get username => _username;
  String get password => _password;

  set index(int value) {
    _index = value;
    liquidController.animateToPage(page: _index,duration: 700);
    update();
  }
  set school(String value) {
    _school = value;
    bool check = !RegExp(r"\w").hasMatch(_school);
    if(_school.length >=4 && check) requestClass();
    update();
  }
  set account(String value) {
    _account = value;
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
  set isLogin(bool value) {
    _isLogin = value;
    update();
  }
  validateID(value) {
    RegExp reg = RegExp(r'^\d{10}$');
    if (!reg.hasMatch(value)) {
      return '请输入10位账号';
    }
  }

  @override
  void onReady() {
    requestSchool();
  }

  Future checkLogin() async{
    user = await Api.login(_account, _password);
    table = await HomeAPI.getTableSet(user?.userId);
    SpUtils.loginAuth = user;
    SpUtils.tableSet = table;
    update();
  }

  Future createUser() async{
    User cUser = User(
      account: _account,
      userName: _username,
      userType: _userType,
      password: _password,
      school: _school,
      className: _classInfo
    );
    user = await Api.createUser(cUser);
    table = await HomeAPI.getTableSet(user?.userId);
    SpUtils.loginAuth = user;
    SpUtils.tableSet = table;
    update();
  }

  Future requestSchool() async{
    _schoolList = await DataAPI.getSchool();
    update();
  }

  Future requestClass() async{
    _classList = await DataAPI.getSchoolClassList(_school);
    update();
  }
}