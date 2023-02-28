import 'package:classes/base/base_controller.dart';
import 'package:classes/http/api.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class SignInLogic extends BaseLogic{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  get textEditingController => _textEditingController;
  late TextEditingController textController;
  final data = ["aaaaa", "cajnfoa", "hhokgo","string"];
  final LiquidController liquidController = LiquidController();
  get formKey => _formKey;
  dynamic? user;
  String _school = "";
  String _username = "";
  String _password = "";

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

  validateID(value) {
    RegExp reg = RegExp(r'^\d{10}$');
    if (!reg.hasMatch(value)) {
      return '请输入10位学号';
    }
  }

  Future checkLogin() async{
    user = await Api.login(username, password, school);
    update();
  }
}