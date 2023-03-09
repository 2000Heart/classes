import 'package:cached_network_image/cached_network_image.dart';
import 'package:classes/base/base_page.dart';
import 'package:classes/logic/mine/my_class_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/colours.dart';

class MyClass extends BasePage{
  MyClass({super.key});

  final MyClassLogic logic = Get.put(MyClassLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<MyClassLogic>(
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(title: Text("我的班级")),
          body: SafeArea(
            child: SingleChildScrollView(
              child: ExpansionPanelList(
                elevation: 0,
                expansionCallback: (index, expanded) {
                  logic.currentIndex != index?logic.currentIndex = index:logic.currentIndex = null;
                },
                children: List.generate(logic.classes.length, (index) => item(index)),
              ),
            ),
          ),
        );
      }
    );
  }

  ExpansionPanel item(int index){
    return ExpansionPanel(
      canTapOnHeader: true,
      backgroundColor: Colors.white,
      isExpanded: logic.currentIndex == index,
      headerBuilder: (context, expanded) => Container(padding: EdgeInsets.only(left: 16),alignment: Alignment.centerLeft,child: Text(logic.classes[index])),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 3,horizontal: 5),
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Wrap(
          spacing: 16,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: List.generate(logic.stu.length, (childIndex) => Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 4,
                      blurStyle: BlurStyle.solid,
                      offset: Offset(2, 2)
                  )
                ],
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: CachedNetworkImage(
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, url, error) => Container(),
                    imageUrl: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202104%2F22%2F20210422220415_2e4bd.jpg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1680746191&t=ddb4b41f1676fbe35e1c2546bf472d0b'),
                ),
                Container(width: 8),
                Text(logic.stu[childIndex])
              ]),
          )
          ),
        ),
      ),
      );
  }
}