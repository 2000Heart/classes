import 'dart:math';

import 'package:classes/logic/lessons/lesson_add_%20check_logic.dart';
import 'package:classes/res/utils.dart';
import 'package:classes/widgets/date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/base_page.dart';
import '../../model/home/home_class_single_day_entity.dart';

class LessonAddCheckPage extends BasePage{
  LessonAddCheckPage({super.key});

  final LessonAddCheckLogic logic = Get.put(LessonAddCheckLogic());
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();
  
  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<LessonAddCheckLogic>(
      initState: (state){
        logic.focus = FocusNode();
      },
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

  Widget checkInfo(){
    return Column(
      children: [
        [
          Text("选择课程",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
          Text("选择")
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
                    logic.data.add(HomeClassSingeDayEntity());
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