import 'package:classes/base/base_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/lessons/lessons_detail_logic.dart';

class LessonsDetailPage extends BasePage {
  LessonsDetailPage({Key? key}) : super(key: key);

  final logic = Get.put(LessonsDetailLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          // onlyOneScrollInBody: true,
          floatHeaderSlivers: true,
          controller: logic.scrollController,
          // pinnedHeaderSliverHeightBuilder: () => kToolbarHeight + MediaQuery.of(context).padding.top,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                toolbarHeight: kToolbarHeight,
                collapsedHeight: kToolbarHeight,
                expandedHeight: 120,
                titleSpacing: 0.0,
                actions: [
                  Container(
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.connected_tv_sharp))
                ],
                iconTheme: const IconThemeData(color: Colors.white),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: const Text("形势与政策",style: TextStyle(fontSize: 18)),
                  expandedTitleScale: 1.1,
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(child: const Text("签到")),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      group(5, 2),
                      Container(width: 15),
                      group(4, 4),
                      Container(width: 15),
                      group(3, 3)
                    ],
                  ),
                ),
                Text("课程任务"),
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text("今日"),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black,width: 1),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black,width: 1),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  childrenPadding: EdgeInsets.symmetric(horizontal: 10),
                  children: List.generate(5, (index) => Container(
                    height: 40,
                    width: Get.width,
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.black,width: 1))
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text("今日任务。。。。。。。。"),
                  )),
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text("昨日"),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black,width: 1),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  collapsedShape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black,width: 1),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  childrenPadding: EdgeInsets.symmetric(horizontal: 10),
                  children: List.generate(5, (index) => Container(
                    height: 40,
                    width: Get.width,
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.black,width: 1))
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text("今日任务。。。。。。。。"),
                  )),
                )
              ],
            ),
          )
      ),
    );
  }

  Widget group(int column,int row){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(column, (index) => Padding(
        padding: EdgeInsets.only(bottom: index != column - 1?5:0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            row, (index) => Padding(
              padding: EdgeInsets.only(right: index != row - 1?5:0),
              child: RawMaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(3),
                fillColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                constraints: BoxConstraints(minWidth: 40,minHeight: 35,maxWidth: 40,maxHeight: 35),
                onPressed: () { Get.back(); },
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("张三张",style: TextStyle(fontSize: 12))),
              ),
            )
          ),
        ),
      )
      ),
    );
  }
}
