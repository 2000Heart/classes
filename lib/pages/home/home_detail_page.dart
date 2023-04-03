import 'dart:ffi';

import 'package:classes/base/base_page.dart';
import 'package:classes/logic/home/home_detail_logic.dart';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/utils.dart';
import 'package:classes/widgets/button.dart';
import 'package:classes/widgets/week_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/unit_picker.dart';

class HomeDetailPage extends BasePage {
  HomeDetailPage({super.key});

  final logic = Get.put(HomeDetailLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<HomeDetailLogic>(
      initState: (state) => logic.requestData(),
      builder: (logic) {
      return Container(
        constraints: BoxConstraints(
            maxWidth: Get.width, maxHeight: Get.height * 0.7),
        margin: EdgeInsets.only(top: 20,bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("课程时间列表",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                  NormalButton(
                      width: 100,height: 40,
                      textStyle: TextStyle(fontSize: 12),
                      text: "课程详情 →",onTap: Get.back)
                ],
              ).paddingOnly(left: 16,right: 16,bottom: 10),
              Column(
                children: List.generate(logic.data.length, (index) =>  scheduleItem(logic.data[index], index)),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget scheduleItem(Schedule entity,int index){
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(0, 5),
                blurRadius: 10,
                spreadRadius: -5
            )
          ]
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(
                entity.lessonName ?? '',
                readOnly: logic.read[index],
                onChanged: (str) => logic.lessonName = str,
                onSubmitted: (str) => logic.lessonName = str,
              ).paddingOnly(bottom: 10),
              text("第${formDuration(entity.duration?.split(",").map((e) => int.parse(e)).toList() ?? [])}周",
                readOnly: true,
              ).tap(() async{
                if(!logic.read[index]) logic.duration = await Get.bottomSheet(const WeekPicker());
              }),
              text("周${weekZh(entity.weekTime ?? 1)} | 第${entity.startUnit}-${entity.endUnit}节", readOnly: true).tap(() async{
                  if(!logic.read[index]) logic.time = await Get.bottomSheet(const UnitPicker());
              }),
              text(
                entity.classroom ?? '',
                readOnly: logic.read[index],
                onChanged: (str) => logic.classroom = str,
                onSubmitted: (str) => logic.classroom = str,
              ),
              text(
                entity.teacherName ?? '',
                readOnly: logic.read[index],
                onChanged: (str) => logic.raw.teacherName = str,
                onSubmitted: (str) => logic.raw.teacherName = str,
              )
            ],
          ),
          if(logic.data[index].userId == UserState.info?.userId.toString())
          Positioned(
              right: 0,
              top: 0,
              child: Text(logic.read[index]?"编辑":"完成").tap(() {
                if(!logic.read[index]){
                  logic.setData(index);
                  logic.updateData();
                }else{
                  logic.raw = logic.data[index];
                }
                logic.read[index] = !logic.read[index];
              }))
        ],
      ),
    );
  }

  Widget text(
      String text,{required bool readOnly,ValueChanged<String>? onChanged,ValueChanged<String>? onSubmitted}
      ){
    return Container(
      height: 20,
      alignment: Alignment.center,
      child: TextField(
        cursorColor: Colors.black,
        readOnly: readOnly,
        expands: true,
        maxLines: null,
        minLines: null,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(vertical: 1),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    );
  }
}