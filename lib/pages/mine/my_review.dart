import 'dart:math';

import 'package:classes/base/base_page.dart';
import 'package:classes/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../res/colours.dart';
import '../../res/utils.dart';

class MyReview extends BasePage{
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("我的记录")),
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
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                blurStyle: BlurStyle.solid,
                offset: Offset(5, 5)
            )
          ]
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              [Text("形式与政策",style: TextStyle(fontSize: 18)),
              Text(formatTime("2023-02-22 19:50:20"))].formLine(),
              Text("总人数：30",style: TextStyle(fontSize: 14)),
              Container(height: 10),
              Text("签到人数：29",style: TextStyle(fontSize: 14))
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 40,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6)
              ),
              child: Text("到课",style: TextStyle(fontSize: 12,color: Colors.white),strutStyle: Styles.center(12)),
            ))
        ],
      ),
    );
  }
}