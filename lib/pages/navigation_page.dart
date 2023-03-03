import 'package:classes/base/base_page.dart';
import 'package:classes/logic/navigation_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationPage extends BasePage {
  NavigationPage({super.key});

  final logic = Get.put(NavigationLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<NavigationLogic>(
      builder: (logic) {
        return Scaffold(
          bottomNavigationBar: _bottomBar(),
          body: PageView(
            physics: const ClampingScrollPhysics(),
            controller: logic.pageController,
            onPageChanged: (value) {
              logic.setIndex(value);
            },
            children: logic.pageList,
          ),
        );
      },
    );
  }

  Widget _bottomBar() {
    return BottomNavigationBar(
        currentIndex: logic.currentIndex,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.amber,
        backgroundColor: Colors.amber,
        onTap: (value) {
          logic.pageController.jumpToPage(value);
        },
        items: List.generate(
            logic.labelList.length,
                (index) =>
                BottomNavigationBarItem(
                    icon: Icon(logic.icon[index]),
                    label: logic.labelList[index],
                    tooltip: ''
                )
        )
    );
  }


}