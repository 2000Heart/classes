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
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();
  
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
          body: CustomScrollView(
            controller: logic.controller,
            slivers: [
              SliverToBoxAdapter(child: checkInfo()),

            ],
          ),
        );
      }
    );
  }

  Widget checkInfo(){
    return Column(
      children: [
        [
          const Text("选择课程",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
          Text("选择").tap(() {
            Get.bottomSheet(const ItemPicker(),
              settings: const RouteSettings(
                name: Routes.itemPicker,arguments: ["string"]
            ));
          })
        ].formLine().paddingSymmetric(horizontal: 16),
        [
          Text("开始时间",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
          Text("13:44开始").tap(() => Get.bottomSheet(DatePicker(needSheet: true),barrierColor: Colors.transparent))
        ].formLine().paddingSymmetric(horizontal: 16),
        [
          Text("结束时间",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
          Text("13:44结束").tap(() => Get.bottomSheet(DatePicker(needSheet: true),barrierColor: Colors.transparent))
        ].formLine().paddingSymmetric(horizontal: 16),
      ],
    );
  }
}