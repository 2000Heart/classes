import 'dart:developer';

import 'package:classes/base/base_page.dart';
import 'package:classes/logic/home/home_add_logic.dart';
import 'package:classes/utils/utils.dart';
import 'package:classes/widgets/button.dart';
import 'package:classes/widgets/unit_picker.dart';
import 'package:classes/widgets/week_picker.dart';
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
          appBar: AppBar(
            title: Text("添加课程"),
            actions: [
              Container(
                padding: const EdgeInsets.only(right: 16),
                alignment: Alignment.center,
                child: Text("保存",style: TextStyle(color: Colors.black.withOpacity(0.7))))
                .tap(() { logic.createSchedule();})
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    lessonInfo(),
                    const Text("上课时间段",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16)),
                    Container(height: 16),
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
                  child: NormalButton.rect(
                    text: "添加",
                    width: 80,
                    height: 40,
                    onTap: () {
                      log("click");
                      logic.timeCount +=1;
                      logic.add();
                      _listKey.currentState?.insertItem(logic.timeCount - 1);
                    }
                  ),
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
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("课程名称",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
              Container(width: 120,
                child: TextField(
                  cursorColor: Colors.black,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    hintText: '请输入课程名称',
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  onChanged: (str) => logic.lessonName = str,
                  onSubmitted: (str) => logic.lessonName = str,
                )),
            ],
          ).paddingSymmetric(horizontal: 16),
        )
      ],
    );
  }

  Widget lessonTime(int index,Animation<double> animation){
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.4),blurRadius: 8,spreadRadius: 1)
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("时间段${index+1}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              blurRadius: 2,
                              blurStyle: BlurStyle.solid,
                              offset: Offset(2,2)
                          )]),
                    child: Text("删除本时段",style: TextStyle(color: Colors.black.withOpacity(0.7)),)
                ).tap(() async{
                  if(logic.timeCount > 1) {
                    _listKey.currentState?.removeItem(index, (context, animation)
                    => lessonTime(index, animation));
                    Future.delayed(Duration(milliseconds: 350)).then((value) {
                      logic.timeCount -= 1;
                      logic.remove(index);
                    });
                  }
                })
              ],
            ),
            Container(height: 16),
            SizedBox(
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("持续时间"),
                  Text("第${formDuration(logic.duration[index])}周")
                      .tap(() async {
                    var list = await Get.bottomSheet(const WeekPicker());
                    if(list != null) logic.setDuration(index, list);
                  }),
                ],
              ),
            ),
            SizedBox(
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("上课时间"),
                  Text("周${weekZh(logic.weekTime[index])} ${logic.unit[index][0]}-${logic.unit[index][1]}节")
                      .tap(() async{
                    var list = await Get.bottomSheet(UnitPicker());
                    logic.weekTime[index] = list[0];
                    logic.setUnit(index, [list[1],list[2]]);
                  }),
                ],
              ),
            ),
            SizedBox(
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("教师"),
                  Container(
                    width: 100,
                    child: TextField(
                      cursorColor: Colors.black,
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: '请输入老师姓名',
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      onChanged: (str) => logic.teacher[index] = str,
                      onSubmitted: (str) => logic.teacher[index] = str,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("教室"),
                  Container(
                      width: 100,
                      child: TextField(
                        cursorColor: Colors.black,
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        style: TextStyle(fontSize: 14),textAlign: TextAlign.end,
                        decoration: InputDecoration(
                          hintText: '请输入教室名称',
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        onChanged: (str) => logic.classroom[index] = str,
                        onSubmitted: (str) => logic.classroom[index] = str,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}