import 'package:classes/base/base_page.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/lessons/lessons_detail_logic.dart';

class LessonsDetailPage extends BasePage {
  LessonsDetailPage({Key? key}) : super(key: key);

  final logic = Get.put(LessonsDetailLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: ExtendedNestedScrollView(
          onlyOneScrollInBody: true,
          floatHeaderSlivers: true,
          physics: const NeverScrollableScrollPhysics(),
          controller: logic.scrollController,
          pinnedHeaderSliverHeightBuilder: () => kToolbarHeight + MediaQuery.of(context).padding.top,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                toolbarHeight: kToolbarHeight,
                collapsedHeight: kToolbarHeight,
                expandedHeight: 120,
                titleSpacing: 0.0,
                iconTheme: const IconThemeData(color: Colors.white),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    height: 120,
                    width: Get.width,
                    color: Colors.red,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              Container(child: const Text("签到")),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      group(5, 2),
                      group(4, 4),
                      group(3, 3)
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }

  Widget group(int column,int row){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(column, (index) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          row, (index) => Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            child: Text("张三"),
          )
        ),
      )
      ),
    );
  }
}
