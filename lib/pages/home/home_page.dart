import 'package:classes/base/base_page.dart';
import 'package:classes/logic/home/home_logic.dart';
import 'package:classes/model/home/home_class_single_day_entity.dart';
import 'package:classes/widgets/grid_unit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//"https://pass.zwu.edu.cn/cas/login?service=https://jw.zwu.edu.cn/sso/drvfivelogin"
class HomePage extends BasePage {
  HomePage({super.key});

  final logic = Get.put(HomeLogic());

  @override
  Widget buildWidget() {
    return GetBuilder<HomeLogic>(builder: (logic) {
      return Scaffold(
          appBar: AppBar(title: Text("${logic.currentIndex}")),
          body: PageView(
            controller: logic.pageController,
            onPageChanged: (index) {
              logic.setIndex(index);
            },
            children: List.generate(15, (index) {
              return weekLessons();}),
          )
      );
    });
  }

  Widget weekLessons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            SizedBox(width: 20, child: Text("12月")),
            GridUnit(child: Text("一")),
            GridUnit(child: Text("二")),
            GridUnit(child: Text("三")),
            GridUnit(child: Text("四")),
            GridUnit(child: Text("五")),
            GridUnit(child: Text("六")),
            GridUnit(child: Text("日")),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                          11, (index) => GridUnit(child: Text("${index + 1}")))
                  ),
                ),
                ClassSingleDay(classes: [
                  HomeClassSingeDayEntity(className: "形势与政策", start: 3, end: 9)
                ]),
                Column(
                  children: const [
                    GridUnit(child: Text("面向对象编程"), color: Colors.green, num: 4)
                  ],
                ),
                Column(
                  children: const [
                    GridUnit(child: Text("英语课"), color: Colors.yellow, num: 4)
                  ],
                ),
                Column(
                  children: const [
                    GridUnit(child: Text("英语课"), color: Colors.blue, num: 4)
                  ],
                ),
                Column(
                  children: const [
                    GridUnit(child: Text("英语课"), color: Colors.red, num: 4)
                  ],
                ),
                Column(
                  children: const [
                    GridUnit(child: Text("英语课"), color: Colors.purple, num: 4)
                  ],
                ),
                Column(
                  children: const [
                    GridUnit(child: Text("英语课"), color: Colors.grey, num: 4)
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

