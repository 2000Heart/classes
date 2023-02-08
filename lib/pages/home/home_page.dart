import 'package:classes/base/base_controller.dart';
import 'package:classes/base/base_page.dart';
import 'package:classes/logic/home/home_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePage extends BasePage{
  HomePage({super.key});

  final logic = Get.put(HomeLogic());
  @override
  Widget buildWidget() {
    return Container(
      child: Text(
          "ZHUYE"
      ),
    );
  }

}

