import 'package:classes/base/base_page.dart';
import 'package:classes/logic/home/home_edit_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeEditPage extends BasePage {
  HomeEditPage({Key? key}) : super(key: key);

  final logic = Get.put(HomeEditLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder(
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RawMaterialButton(
                onPressed: () {
                  Get.back();
                },
                fillColor: Colors.white,
                splashColor: Colors.transparent,
                child: const Text("前往课程详情"),
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
        );
      }
    );
  }
}
