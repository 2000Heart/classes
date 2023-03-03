import 'dart:math';

import 'package:classes/base/base_page.dart';
import 'package:flutter/material.dart';

class MessagesPage extends BasePage{
  const MessagesPage({super.key});

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("消息")),
      body: ListView(
        children: List.generate(10, (index) => message()),
      ),
    );
  }


  Widget message(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("课程名"),
            Text("时间"),
          ],
        ),
        Wrap(
          children: [
            Text("${List.generate(Random.secure().nextInt(20), (index) => "内容").join()}")
          ],
        )
      ],
    );
  }
}