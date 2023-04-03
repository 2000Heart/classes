import 'package:classes/base/base_page.dart';
import 'package:classes/logic/navigation_logic.dart';
import 'package:classes/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../http/home_api.dart';
import '../res/colours.dart';
import '../states/user_state.dart';
import '../utils/sp_utils.dart';

class NavigationPage extends BasePage {
  NavigationPage({super.key});

  late final NavigationLogic logic;

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<NavigationLogic>(
      init: logic = Get.put(NavigationLogic()),
      initState: (state) async{
        if(Get.arguments == "sign") {
          logic.currentIndex = 0;
        }
        if(UserState.info != null) SpUtils.tableSet = await HomeAPI.getTableSet(UserState.info?.userId);
      },
      builder: (logic) {
        return Scaffold(
          bottomNavigationBar: _bottomBar(),
          body: PageView(
            physics: const ClampingScrollPhysics(),
            controller: logic.pageController,
            onPageChanged: (value) {
              logic.currentIndex = value;
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