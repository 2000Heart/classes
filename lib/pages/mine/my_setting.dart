import 'package:classes/base/base_page.dart';
import 'package:classes/res/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySetting extends BasePage{
  const MySetting({super.key});

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("我的设置")),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white,
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
              children: [
                [Text("账号"),Text("1148158220")].formLine(),
                [Text("姓名"),Text("张三")].formLine(),
                [Text("密码"),
                  Container(
                    width: Get.width/2,
                    child: TextField(
                      textAlign: TextAlign.end,
                      cursorColor: Colors.black,
                      maxLines: 1,
                      obscureText: true,
                      readOnly: true,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: '请输入课程名称',
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  )].formLine()
              ],
            )
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
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
                children: [
                  [Text("学校"),Text("浙江万里学院")].formLine(),
                  [Text("班级"),Text("物联网191")].formLine(),
                  // [Text("密码"),
                  //   Container(
                  //     width: Get.width/2,
                  //     child: TextField(
                  //       textAlign: TextAlign.end,
                  //       cursorColor: Colors.black,
                  //       maxLines: 1,
                  //       obscureText: true,
                  //       readOnly: true,
                  //       style: TextStyle(fontSize: 14),
                  //       decoration: InputDecoration(
                  //         hintText: '请输入课程名称',
                  //         contentPadding: EdgeInsets.symmetric(vertical: 5),
                  //         focusedBorder: InputBorder.none,
                  //         enabledBorder: InputBorder.none,
                  //       ),
                  //     ),
                  //   )].formLine()
                ],
              )
          ),
        ],
      )
    );
  }

}