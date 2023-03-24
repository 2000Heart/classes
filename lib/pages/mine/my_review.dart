import 'dart:math';

import 'package:classes/base/base_page.dart';
import 'package:classes/logic/mine/my_review_logic.dart';
import 'package:classes/model/lessons/check_history_entity.dart';
import 'package:classes/res/styles.dart';
import 'package:classes/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:classes/utils/utils.dart';
import 'package:get/get.dart';

class MyReview extends BasePage{
  MyReview({super.key});

  final MyReviewLogic logic = Get.put(MyReviewLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<MyReviewLogic>(
      initState: (state) => logic.requestData(),
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text("我的记录")),
          body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView(
              children: List.generate(logic.checkList.length, (index) => message(logic.checkList[index])),
            ),
          ),
        );
      }
    );
  }


  Widget message(CheckHistory entity){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                blurStyle: BlurStyle.solid,
                offset: const Offset(5, 5)
            )
          ]
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              [Text(entity.lessonName ?? "",style: TextStyle(fontSize: 18)),
              Text(formatTime("2023-02-22 19:50:20"))].formLine(),
              Text("总人数：${entity.need}",style: TextStyle(fontSize: 14)),
              Container(height: 10),
              Text("签到人数：${entity.checked}",style: TextStyle(fontSize: 14)),
              if(UserState.info?.userType==1)
              Text("缺勤：${entity.miss}",softWrap: true).paddingOnly(top: 10)
            ],
          ),
          if(UserState.info?.userType==0)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 40,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: entity.checked==0?Colors.blue:Colors.red,
                borderRadius: BorderRadius.circular(6)
              ),
              child: Text(entity.checked==0?"缺勤":"到课",style: TextStyle(fontSize: 12,color: Colors.white),strutStyle: Styles.center(12)),
            ))
        ],
      ),
    );
  }
}