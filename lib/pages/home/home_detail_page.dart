import 'package:classes/base/base_page.dart';
import 'package:classes/logic/home/home_detail_logic.dart';
import 'package:classes/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDetailPage extends BasePage {
  HomeDetailPage({super.key});

  final logic = Get.put(HomeDetailLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<HomeDetailLogic>(builder: (logic) {
      return Container(
        margin: EdgeInsets.only(top: 20,bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("课程时间列表",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                  NormalButton(
                      width: 100,height: 40,
                      textStyle: TextStyle(fontSize: 12),
                      text: "课程详情 →",onTap: Get.back)
                ],
              ).paddingOnly(left: 16,right: 16,bottom: 10),
              Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 5),
                      blurRadius: 10,
                      spreadRadius: -5
                    )
                  ]
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("形势与政策").paddingOnly(bottom: 5),
                        Text("第1-6周").paddingOnly(bottom: 5),
                        Text("周一|第1-4节|08:00-11:25").paddingOnly(bottom: 5),
                        Text("教室：钱湖校区 钱湖1212").paddingOnly(bottom: 5),
                        Text("老师：张三")
                      ],
                    ),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: Text("编辑"))
                  ],
                ),
              ),
              Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 5),
                        blurRadius: 10,
                        spreadRadius: -5
                      )
                    ]
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("形势与政策").paddingOnly(bottom: 5),
                        Text("第1-6周").paddingOnly(bottom: 5),
                        Text("周一|第1-4节|08:00-11:25").paddingOnly(bottom: 5),
                        Text("教室：钱湖校区 钱湖1212").paddingOnly(bottom: 5),
                        Text("老师：张三")
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Text("编辑"))
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

}