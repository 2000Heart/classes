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
    return ExtendedNestedScrollView(
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
              expandedHeight: 60,
              titleSpacing: 0.0,
              iconTheme: const IconThemeData(color: Colors.white),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.pin,
                background: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  height: 80,
                  width: Get.width,
                  color: Colors.red,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ];
        },
        body: Container()
    );
  }
}
