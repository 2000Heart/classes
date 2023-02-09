import 'package:classes/base/base_page.dart';
import 'package:classes/logic/home/home_logic.dart';
import 'package:classes/widgets/grid_unit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//"https://pass.zwu.edu.cn/cas/login?service=https://jw.zwu.edu.cn/sso/drvfivelogin"
class HomePage extends BasePage{
  HomePage({super.key});

  final logic = Get.put(HomeLogic());

  @override
  Widget buildWidget() {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 20,child: const Text("12月")),
              const GridUnit(child: Text("一")),
              const GridUnit(child: Text("二")),
              const GridUnit(child: Text("三")),
              const GridUnit(child: Text("四")),
              const GridUnit(child: Text("五")),
              const GridUnit(child: Text("六")),
              const GridUnit(child: Text("日")),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(11, (index) => GridUnit(child: Text("${index + 1}")))
                    ),
                  ),
                  Column(
                    children: const [
                      GridUnit(child: Text("英语课"),color: Colors.pink,num: 4)
                    ],
                  ),
                  Column(
                    children: const [
                      GridUnit(child: Text("英语课"),color: Colors.green,num: 4)
                    ],
                  ),
                  Column(
                    children: const [
                      GridUnit(child: Text("英语课"),color: Colors.yellow,num: 4)
                    ],
                  ),
                  Column(
                    children: const [
                      GridUnit(child: Text("英语课"),color: Colors.blue,num: 4)
                    ],
                  ),
                  Column(
                    children: const [
                      GridUnit(child: Text("英语课"),color: Colors.red,num: 4)
                    ],
                  ),
                  Column(
                    children: const [
                      GridUnit(child: Text("英语课"),color: Colors.purple,num: 4)
                    ],
                  ),
                  Column(
                    children: const [
                      GridUnit(child: Text("英语课"),color: Colors.grey,num: 4)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }

}

