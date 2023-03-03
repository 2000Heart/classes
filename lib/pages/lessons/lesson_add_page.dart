import 'package:classes/base/base_page.dart';
import 'package:classes/logic/lessons/lesson_add_logic.dart';
import 'package:classes/widgets/week_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../model/home/home_class_single_day_entity.dart';
import '../../res/utils.dart';

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
          appBar: AppBar(title: Text("添加课程")),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("课程名称"),
                    Container(width: 60,child: TextField()),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("课程时间"),
                    Text("选择").tap(() { Get.bottomSheet(WeekPicker(length: 20));})
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("上课班级"),
                        Text("选择")
                      ],
                    ),
                    Wrap(
                      children: List.generate(9, (index) => Text("物联网19${index + 1}")),
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("选择教室"),
                    Row(
                        children: [
                          Container(child: Text("选择已有教室")).tap(() {logic.choice = true;}),
                          Container(child: Text("新增教室")).tap(() {logic.choice = false;})
                        ]),
                  ],
                ),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("第${index+1}组"),
              Text(logic.timeCount -1  > index && logic.timeCount != 1?"删除":"添加").tap(() {
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
            ],
          ),
          Row(
            children: [
              Container(width: 60,child: TextField(
                onChanged: (str){},
              )),
              Text("列"),
              Container(width: 60,child: TextField()),
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
              logic.roomList.length,
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
}