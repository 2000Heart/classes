import 'dart:math';

import 'package:classes/base/base_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:classes/utils/utils.dart';

class MessagesPage extends BasePage{
  const MessagesPage({super.key});

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("消息")),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          children: List.generate(10, (index) => message()),
        ),
      ),
    );
  }


  Widget message(){
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
            height: 40,
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
                Text("形式与政策",style: TextStyle(fontSize: 18)),
                Text(formatTime("2023-02-22 19:50:20")),
              ],
            ),
          ),
          Wrap(
            children: [
              Text("${List.generate(Random.secure().nextInt(20), (index) => "内容").join()}")
            ],
          ).paddingSymmetric(horizontal: 12,vertical: 10)
        ],
      ),
    );
  }
}