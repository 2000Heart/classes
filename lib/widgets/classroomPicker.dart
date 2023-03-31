import 'package:classes/http/data_api.dart';
import 'package:classes/model/data/classroom.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/toast_utils.dart';
import 'package:classes/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'button.dart';

class ClassroomPicker extends StatefulWidget {
  const ClassroomPicker({Key? key}) : super(key: key);

  @override
  State<ClassroomPicker> createState() => _ClassroomPickerState();
}

class _ClassroomPickerState extends State<ClassroomPicker> {
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();
  bool _choice = true;
  List<Classroom> _data = [];
  int _timeCount = 1;
  String? _roomName;
  List<int> _row = [0];
  List<int> _column = [0];
  String _input = "";
  String? _result;
  int? tapped;
  List<Classroom> _findList = [];

  set timeCount(int value) {
    _timeCount = value;
    update();
  }
  set roomName(String value) {
    _roomName = value;
    update();
  }
  set choice(bool value) {
    _choice = value;
    update();
  }

  Future requestData() async{
    _data = await DataAPI.getClassroomList() ?? [];
  }

  Future getInput(str) async{
    _input = str;
    _findList.clear();
    if(_input != ''){
      for (var element in _data) {
        if(element.roomName?.contains(RegExp(str,caseSensitive: false)) == true){
          _findList.add(element);
        }
      }
    }
    update();
  }

  @override
  void initState() {
    super.initState();
    requestData();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      elevation: 40,
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(16))
      ),
      constraints: BoxConstraints(
          maxWidth: Get.width,maxHeight: Get.height*0.5),
      onClosing: () {  },
      builder:  (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30,top: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NormalButton.rect(text: "取消", width: 80,height: 35,onTap: Get.back),
                  NormalButton.rect(text: "确认", width: 80,height: 35,
                    onTap: () async{
                      if(!_choice){
                        var classroom = await DataAPI.createClassroom(Classroom(
                          schoolName: UserState.info?.school,
                          roomName: _roomName,
                          row: _row.join(","),
                          column: _column.join(",")
                        ).toJson());
                        _result = classroom?.roomName;
                      }
                      Get.back(result: _result);
                    })
                ],
              ).paddingSymmetric(horizontal: 16),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 10),
                          [
                            Text("选择教室",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                            Row(
                                children: [
                                  Container(child: Text("选择已有教室")).tap(() {choice = true;}),
                                  Text(" | "),
                                  Container(child: Text("新增教室")).tap(() {choice = false;})
                                ])
                          ].formLine(),
                          [Text("教室名",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                            if(!_choice)Container(
                              height: 20,
                              width: 120,
                              alignment: Alignment.center,
                              child: TextField(
                                cursorColor: Colors.black,
                                readOnly: _choice,
                                expands: true,
                                maxLines: null,
                                minLines: null,
                                textAlign: TextAlign.end,
                                style: const TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: _roomName??"暂未填写",
                                  hintStyle: const TextStyle(color: Colors.black),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 1),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                                onChanged: (str) => roomName = str,
                                onSubmitted: (str) => roomName = str,
                              ),
                            )].formLine()
                        ],
                      ).paddingSymmetric(horizontal: 16),
                    ),
                    _choice?SliverToBoxAdapter(child: chooseList(context)):SliverAnimatedList(
                        key: _listKey,
                        initialItemCount: _timeCount,
                        itemBuilder: (BuildContext context, int index, Animation<double> animation){
                          return groupList(index,animation);
                        }
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
                child: Text(_timeCount-1  > index && _timeCount != 1?"删除":"添加").tap(() {
                  if(_timeCount - 1 == index) {
                    _timeCount += 1;
                    _row.add(0);
                    _column.add(0);
                    _data.add(Classroom(
                      schoolName: UserState.info?.school ?? ''
                    ));
                    _listKey.currentState?.insertItem(_timeCount - 1);
                  }else {
                    if (_timeCount > 1) {
                      _timeCount -= 1;
                      _data.removeAt(index);
                      _row.removeAt(index);
                      _column.removeAt(index);
                      _listKey.currentState?.removeItem(
                          index, (context, animation) =>
                          groupList(index, animation));
                    }
                  }
                  update();
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
            onChanged: (str) {
              if(!str.isNullOrEmpty) {
                if (int.tryParse(str) == null) {
                  ToastUtils.show("请输入数字");
                } else {
                  _column[index] = int.parse(str);
                  update();
                }
              }
            },
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
              onChanged: (str){
                if(!str.isNullOrEmpty) {
                  if (int.tryParse(str) == null) {
                    ToastUtils.show("请输入数字");
                  } else {
                    _row[index] = int.parse(str);
                    update();
                  }
                }
              },
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
          children: List.generate(_findList.length, (index) => _searchItem(index)),
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
                  expands: true,
                  cursorColor: Colors.blue,
                  maxLines: null,
                  minLines: null,
                  onChanged: (str) => getInput(str),
                  onSubmitted: (str) => getInput(str),
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
      margin: EdgeInsets.only(bottom: 8,left: 10,right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 2,
                blurStyle: BlurStyle.solid,
                offset: Offset(index==tapped?5:1, index==tapped?5:1)
            )
          ]),
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
              Text(_findList[index].roomName ?? ""),
              Text(_findList[index].schoolName ?? "")
            ],
          ),
        ],
      ),
    ).tap(() {
      tapped = index;
      _result = _findList[index].roomName;
      update();
    });
  }

}
