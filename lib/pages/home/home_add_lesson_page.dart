import 'dart:developer';

import 'package:classes/base/base_page.dart';
import 'package:classes/logic/home/home_add_loigc.dart';
import 'package:classes/model/home/home_class_single_day_entity.dart';
import 'package:classes/res/utils.dart';
import 'package:classes/widgets/unit_picker.dart';
import 'package:classes/widgets/week_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAddLessonPage extends BasePage{
  HomeAddLessonPage({super.key});

  final HomeAddLogic logic = Get.put(HomeAddLogic());
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();
  
  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<HomeAddLogic>(
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(title: Text("添加课程")),
          body: CustomScrollView(
            controller: logic.controller,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    lessonInfo(),
                    Row(
                        children: [
                          Text("上课时间段"),
                        ]
                    ),
                  ],
                ),
              ),
              SliverAnimatedList(
                key: _listKey,
                initialItemCount: logic.timeCount,
                itemBuilder: (BuildContext context, int index, Animation<double> animation){
                  return lessonTime(index,animation);
                }
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: const Text("添加").tap(() {
                    log("click");
                    logic.timeCount +=1;
                    logic.data.add(HomeClassSingeDayEntity());
                    _listKey.currentState?.insertItem(logic.timeCount - 1);
                  }),
                )
              )
            ],
          ),
        );
      }
    );
  }

  Widget lessonInfo(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("课程名称"),
            Container(width: 80,child: TextFormField()),
          ],
        )
      ],
    );
  }

  Widget lessonTime(int index,Animation<double> animation){
    return SizeTransition(
      sizeFactor: animation,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("时间段${index+1}"),
              Text("删除本时段").tap(() {
                if(logic.timeCount > 1) {
                  logic.timeCount -= 1;
                  logic.data.removeAt(index);
                  _listKey.currentState?.removeItem(index, (context, animation)
                    => lessonTime(index, animation));
                }
              })
            ],
          ),
          Text("第1-20周").tap(() => Get.bottomSheet(WeekPicker(length: 20))),
          Text("周三 2-9节").tap(() => Get.bottomSheet(UnitPicker())),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("教师"),
              Container(width: 80,child: TextFormField()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("教室"),
              Container(width: 80,child: TextFormField()),
            ],
          )
        ],
      ),
    );
  }
}