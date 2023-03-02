import 'package:classes/logic/lessons/lesson_add_%20check_logic.dart';
import 'package:classes/res/utils.dart';
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
        Future.delayed(const Duration(milliseconds: 600)).then((value) => FocusScope.of(context).requestFocus(logic.focus));
      },
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(title: Text("设置签到")),
          body: CustomScrollView(
            controller: logic.controller,
            slivers: [
              SliverToBoxAdapter(child: checkInfo()),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("选择课程"),
            Text("形式与政策")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("选择时间"),
            Text("13:44开始 持续10分钟")
          ],
        ),
        Text("选择教室"),
        Row(
          children: [
            Container(child: Text("选择已有教室")).tap(() {logic.choice = true;}),
            Container(child: Text("新增教室")).tap(() {logic.choice = false;})
          ]),

      ],
    );
  }

  Widget groupList(int index,Animation<double> animation){
    return SizeTransition(
      sizeFactor: animation,
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("第${index+1}组"),
              Text(logic.timeCount > index?"删除":"添加").tap(() {
                if(logic.timeCount > index) {
                  logic.timeCount += 1;
                  logic.timeCount +=1;
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
            ],
          ),
          Row(
            children: [
              TextFormField(),
              Text("列"),
              TextFormField(),
              Text("行")
            ],
          )
        ],
      ),
    );
  }

  Widget chooseList(context){
    return Column(
      children: [
        _searchBar(context),
        Column(
          children: List.generate(
            logic.classList.length,
            (index) => _searchItem(index)),
        )
      ],
    );
  }

  Widget _searchBar(context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 8, bottom: 8,right: 16),
      child: Row(
        children: [
          GestureDetector(
              onTap: Get.back,
              child: Image.asset(Utils.getImgPath('arrow_back.png'))),
          Expanded(
            child: Container(
                height: 34,
                padding: const EdgeInsets.only(right: 10),
                child: Hero(
                  tag: "search",
                  child: TextField(
                    controller: logic.editingController,
                    enabled: true,
                    cursorColor: Colors.blue,
                    maxLines: 1,
                    focusNode: logic.focus,
                    onTap: () =>
                        FocusScope.of(context).requestFocus(logic.focus),
                    onChanged: (str) async => await logic.getInput(str),
                    onSubmitted: (str) {
                      logic.focus.unfocus();
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        prefixIcon: Icon(Icons.search_rounded,color: Colors.white24,size: 16),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                          BorderRadius.all(Radius.circular(35 / 2)),
                        ),
                        hintText: "搜索教室",
                        hintStyle: const TextStyle(fontSize: 16,height: 1.2)),
                  ),
                )),
          ),
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: logic.focus.unfocus,
              child: Text("搜索",style: TextStyle(fontSize: 16,color: Colors.black87)))
        ],
      ),
    );
  }

  Widget _searchItem(int index){
    return Column(
      children: [
        Text("一号楼2308"),
        Text("浙江万里学院")
      ],
    );
  }

  Widget datePicker(String time){
    return Column(
      children: [
        Expanded(
            child: CupertinoDatePicker(
              use24hFormat: true,
              initialDateTime: DateTime.parse("12:00"),
              onDateTimeChanged: (date){
                time = date.toIso8601String();
              },
              mode: CupertinoDatePickerMode.dateAndTime,
            )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("持续时间"),
            Row(
              children: [
                TextFormField(),
                Text("分钟")
              ],
            )
          ],
        )
      ],
    );
  }
}