import 'dart:math';

import 'package:classes/base/base_page.dart';
import 'package:classes/logic/message/message_logic.dart';
import 'package:classes/model/message_entity.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:classes/utils/utils.dart';

import '../../res/colours.dart';

class MessagesPage extends BasePage{
  MessagesPage({super.key});

  final MessageLogic logic = Get.put(MessageLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<MessageLogic>(
      initState: (state) => logic.requestData(),
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text("宠物")),
          body: Container(
            width: Get.width,
            height: Get.height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFe8ddc2),Color(0xFFC9E8E1)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)
            ),
            child: Image.asset(
            width: Get.width,
            fit: BoxFit.fitWidth,
            Utils.getImgPath("cat.jpeg")),
          )
          // EasyRefresh.builder(
          //   header: const ClassicHeader(
          //     position: IndicatorPosition.locator,
          //     dragText: "下拉刷新",
          //     armedText: "松开刷新",
          //     failedText: "刷新失败",
          //     readyText: "正在刷新...",
          //     processingText: "正在刷新...",
          //     processedText: "刷新完成",
          //     messageText: '上次更新时间 %T',
          //     showMessage: false,
          //     iconTheme: IconThemeData(color: Colors.black),
          //     textStyle: TextStyle(fontSize: 12, color: Colours.grey),
          //     messageStyle: TextStyle(fontSize: 10),
          //   ),
          //   onRefresh: () => logic.requestData(),
          //   childBuilder: (BuildContext context, ScrollPhysics physics) =>
          //     Padding(
          //       padding: const EdgeInsets.only(top: 10),
          //       child: CustomScrollView(
          //         physics: physics,
          //         slivers: [
          //           HeaderLocator.sliver(),
          //           SliverList(delegate: SliverChildListDelegate(
          //             List.generate(logic.messages.length,
          //               (index) => message(logic.messages[index]))
          //           ))
          //         ],
          //       ),
          //     ),
          // )
        );
      }
    );
  }


  Widget message(Message entity){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              blurStyle: BlurStyle.solid,
              offset: Offset(5, 5)
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 32,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), topLeft: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    blurStyle: BlurStyle.solid,
                    offset: Offset(2, 2)
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(entity.title ?? "",style: TextStyle(fontSize: 16)),
                Text(formatTime(entity.postTime ?? ""),style: TextStyle(fontSize: 12,color: Colours.TEXT_BLACK_LIGHT)),
              ],
            ),
          ),
          Wrap(
            children: [
              Text(entity.content ?? "")
            ],
          ).paddingSymmetric(horizontal: 12,vertical: 10)
        ],
      ),
    );
  }
}