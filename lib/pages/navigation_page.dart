import 'package:classes/base/base_controller.dart';
import 'package:classes/base/base_page.dart';
import 'package:classes/logic/navigation_logic.dart';
import 'package:classes/states/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationPage extends BasePage{
  NavigationPage({super.key});

  final controller = Get.put(NavigationLogic());

  @override
  init() => controller;

  @override
  Widget buildWidget() {
    return Scaffold(
      appBar: AppBar(title: Text(controller.labelList[controller.currentIndex])),
      bottomNavigationBar: _bottomBar(),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (value){
          controller.setIndex(value);
        },
        children: controller.pageList,
      ),
    );
  }

  Widget _bottomBar(){
    return BottomNavigationBar(
      currentIndex: controller.currentIndex,
      onTap: (value){
        controller.pageController.jumpToPage(value);
      },
        items: List.generate(
          controller.labelList.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(controller.icon[index]),
            label: controller.labelList[index],
            tooltip: ''
          )
        )
    );
  }



}