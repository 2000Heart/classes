import 'package:classes/base/base_controller.dart';
import 'package:classes/base/base_page.dart';
import 'package:classes/logic/mine/mine_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MinePage extends BasePage{
  MinePage({super.key});

  final controller = Get.put(MineLogic());
  @override
  Widget buildWidget() {
    return Container();
  }

  @override
  BaseController init() => controller;

}