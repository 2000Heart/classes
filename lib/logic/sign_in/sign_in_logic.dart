import 'package:classes/base/base_controller.dart';
import 'package:flutter/material.dart';

class SignInLogic extends BaseLogic{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  get textEditingController => _textEditingController;
  var i = 0;
  get formKey => _formKey;

  validateID(value) {
    RegExp reg = RegExp(r'^\d{10}$');
    if (!reg.hasMatch(value)) {
      return '请输入10位学号';
    }
  }
}