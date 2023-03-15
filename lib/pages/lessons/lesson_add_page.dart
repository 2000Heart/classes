import 'dart:ffi';

import 'package:classes/base/base_page.dart';
import 'package:classes/logic/lessons/lesson_add_logic.dart';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/utils/utils.dart';
import 'package:classes/widgets/week_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LessonAddPage extends BasePage{
  LessonAddPage({super.key});

  final LessonAddLogic logic = Get.put(LessonAddLogic());
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();


  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<LessonAddLogic>(
      initState: (state){
        logic.focus = FocusNode();
      },
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
              SliverToBoxAdapter(
                child: [
                    Text("课程时间",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                    Text("选择").tap(() { Get.bottomSheet(WeekPicker());})
                  ].formLine().paddingSymmetric(horizontal: 16),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    )
                  ],
                ).paddingSymmetric(horizontal: 16),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 10),
                    [
                    Text("选择教室",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                    Row(
                        children: [
                          Container(child: Text("选择已有教室")).tap(() {logic.choice = true;}),
                          Text(" | "),
                          Container(child: Text("新增教室")).tap(() {logic.choice = false;})
                        ])
                    ].formLine(),
                    [Text("教室名",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),Text("2308")].formLine()
                  ],
                ).paddingSymmetric(horizontal: 16),
              ),
              logic.choice?SliverToBoxAdapter(child: chooseList(context)):SliverAnimatedList(
                  key: _listKey,
                  initialItemCount: logic.timeCount,
                  itemBuilder: (BuildContext context, int index, Animation<double> animation){
                    return groupList(index,animation);
                  }
              )
            ],
          ),
        );
      }
    );
  }

  Widget groupList(int index,Animation<double> animation){
    return SizeTransition(
      sizeFactor: animation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("第${index+1}组"),
              Container(
                margin: EdgeInsets.only(left: 10),
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
                child: Text(logic.timeCount -1  > index && logic.timeCount != 1?"删除":"添加").tap(() {
                  if(logic.timeCount - 1 == index) {
                    logic.timeCount += 1;
                    logic.data.add(Schedule());
                    _listKey.currentState?.insertItem(logic.timeCount - 1);
                  }else {
                    if (logic.timeCount > 1) {
                      logic.timeCount -= 1;
                      logic.data.removeAt(index);
                      _listKey.currentState?.removeItem(
                          index, (context, animation) =>
                          groupList(index, animation));
                    }
                  }
                }),
              ),
            ],
          ),
          [Container(width: 30,height: 30,child: TextField(
            expands: true,
            maxLines: null,
            minLines: null,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 5),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            ),
            onChanged: (str){},
            )),
            Text("列"),
            Container(width: 5),
            Container(width: 30,height: 30,child: TextField(
              expands: true,
              maxLines: null,
              minLines: null,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              ),
              onChanged: (str){},
            )),
            Text("行")
          ].formLine(),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }

  Widget chooseList(context){
    return Column(
      children: [
        _searchBar(context),
        Column(
          children: List.generate(
              logic.reRoomList.length,
                  (index) => _searchItem(index)),
        )
      ],
    );
  }

  Widget _searchBar(context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 16,top: 8, bottom: 8,right: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35 / 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 4,
                    )
                  ]
                ),
                child: TextField(
                  controller: logic.editingController,
                  enabled: true,
                  expands: true,
                  cursorColor: Colors.blue,
                  maxLines: null,
                  minLines: null,
                  focusNode: logic.focus,
                  onTap: () =>
                      FocusScope.of(context).requestFocus(logic.focus),
                  onChanged: (str) => logic.getInput(str),
                  onSubmitted: (str) {
                    logic.focus.unfocus();
                  },
                  decoration: InputDecoration(
                      filled: true,
                      constraints: BoxConstraints(maxHeight: 34),
                      contentPadding: EdgeInsets.all(5),
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search_rounded,color: Colors.black.withOpacity(0.8),size: 16),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                        BorderRadius.all(Radius.circular(35 / 2)),
                      ),
                      hintText: "搜索教室",
                      hintStyle: const TextStyle(fontSize: 16,height: 1.2)),
                )),
          ),
        ],
      ),
    );
  }

  Widget _searchItem(int index){
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(width: 10),
          Icon(Icons.home_outlined,size: 30),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 2,
            height: 30,
            color: Colors.black,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(logic.reRoomList[index]),
              Text("浙江万里学院")
            ],
          ),
        ],
      ),
    );
  }
}