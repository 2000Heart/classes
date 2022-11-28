import 'package:classes/base/base_controller.dart';
import 'package:classes/base/base_page.dart';
import 'package:classes/logic/lessons/lessons_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LessonsPage extends BasePage{
  LessonsPage({super.key});

  final controller = Get.put(LessonsLogic());

  @override
  Widget buildWidget() {
    return Container();
  }

  @override
  BaseController init() => controller;

}