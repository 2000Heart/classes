import 'package:classes/base/base_page.dart';
import 'package:classes/logic/navigation_logic.dart';
import 'package:classes/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/colours.dart';

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
    return BottomBar(
        currentIndex: logic.currentIndex,
        onTap: (value) {
          logic.pageController.jumpToPage(value);
        },
        items: List.generate(
            logic.labelList.length,
                (index) =>
                BottomBarItemData(
                  icon: logic.icon[index],
                  title: logic.labelList[index],
                  width: 120,
                  selectedColor: Colours.navigationColors[index],
                )
        ),
    );
  }


}