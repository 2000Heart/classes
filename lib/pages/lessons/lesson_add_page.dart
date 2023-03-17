import 'dart:ffi';

import 'package:classes/base/base_page.dart';
import 'package:classes/logic/lessons/lesson_add_logic.dart';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/utils/utils.dart';
import 'package:classes/widgets/classroomPicker.dart';
import 'package:classes/widgets/week_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../widgets/button.dart';
import '../../widgets/unit_picker.dart';

class LessonAddPage extends BasePage{
  LessonAddPage({super.key});

  final LessonAddLogic logic = Get.put(LessonAddLogic());
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();


  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<LessonAddLogic>(
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(title: Text("添加课程"),actions: [
            Container(
                padding: const EdgeInsets.only(right: 16),
                alignment: Alignment.center,
                child: Text("保存",style: TextStyle(color: Colors.black.withOpacity(0.7))))
          ]),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(height: 20),
              ),
              SliverToBoxAdapter(
                child:[
                  Text("课程名称",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                  Container(
                    width: 100,
                    child: TextField(
                      cursorColor: Colors.black,
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: '请输入课程名称',
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  )
                ].formLine().paddingSymmetric(horizontal: 16),
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
                          logic.timeCount +=1;
                          logic.data.add(logic.data[logic.timeCount-1]);
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
                      logic.data.removeAt(index);
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
                  Text(logic.data[index].duration == null?"选择":"第${formDuration(logic.data[index].duration?.split(",").map((e) => int.parse(e)).toList() ?? [])}周")
                      .tap(() async {
                    var list = await Get.bottomSheet(const WeekPicker());
                    if(list != null) logic.duration(index, list.join(","));
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
                  Text(logic.data[index].weekTime == null?"选择":"周${weekZh(logic.data[index].weekTime ?? 0)} ${logic.data[index].startUnit}-${logic.data[index].endUnit}节")
                      .tap(() async{
                    var list = await Get.bottomSheet(UnitPicker());
                    logic.time(index, list);
                  }),
                ],
              ),
            ),
            [Text("上课班级",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
              Text("选择")].formLine(),
            Center(
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: List.generate(9, (index) =>
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurStyle: BlurStyle.solid,
                                blurRadius: 3,offset: Offset(2, 2)
                            )]
                        ),
                        child: Text("物联网19${index + 1}")
                    )
                ),
              ),
            ).paddingOnly(bottom: 5),
            SizedBox(
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("教室"),
                  Text(logic.data[index].classroom ?? "选择").tap(() async {
                    var room = await Get.bottomSheet(const ClassroomPicker(),isScrollControlled: true);
                    if(room != null)logic.classroom(index, room);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}