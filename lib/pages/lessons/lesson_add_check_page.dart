import 'dart:math';

import 'package:classes/logic/lessons/lesson_add_%20check_logic.dart';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/res/routes.dart';
import 'package:classes/utils/utils.dart';
import 'package:classes/widgets/date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/base_page.dart';
import '../../widgets/item_picker.dart';
import '../../widgets/unit_picker.dart';
import '../../widgets/week_picker.dart';

class LessonAddCheckPage extends BasePage{
  LessonAddCheckPage({super.key});

  final LessonAddCheckLogic logic = Get.put(LessonAddCheckLogic());
  
  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<LessonAddCheckLogic>(
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(title: Text("设置签到"),actions: [
            Container(
                padding: const EdgeInsets.only(right: 16),
                alignment: Alignment.center,
                child: Text("保存",style: TextStyle(color: Colors.black.withOpacity(0.7))))
          ],),
          body: Column(
            children: [
              [
                const Text("选择课程",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                Text(logic.choice == null?"选择":logic.itemList[logic.choice!]).tap(() async{
                  var str = await Get.bottomSheet(const ItemPicker(),
                      settings: RouteSettings(
                          name: Routes.itemPicker,arguments: logic.itemList
                      ));
                  if(str != null) logic.choice = logic.itemList.indexOf(str);
                })
              ].formLine().paddingSymmetric(horizontal: 16),
              [
                Text("开始时间",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                Text(logic.startTime ?? "选择").tap(() async{
                  var str = await Get.bottomSheet(DatePicker(needSheet: true),barrierColor: Colors.transparent);
                  if(str != null) logic.startTime = str;
                })
              ].formLine().paddingSymmetric(horizontal: 16),
              [
                Text("结束时间",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                Text(logic.endTime ?? "选择").tap(() async{
                  var str = await Get.bottomSheet(DatePicker(needSheet: true),barrierColor: Colors.transparent);
                  if(str != null) logic.startTime = str;
                })
              ].formLine().paddingSymmetric(horizontal: 16),
            ],
          )
        );
      }
    );
  }
}