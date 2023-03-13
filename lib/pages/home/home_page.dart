import 'package:classes/base/base_page.dart';
import 'package:classes/logic/home/home_logic.dart';
import 'package:classes/model/home/table_set.dart';
import 'package:classes/model/user_entity.dart';
import 'package:classes/res/routes.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/sp_utils.dart';
import 'package:classes/utils/utils.dart';
import 'package:classes/widgets/colourful_wrap.dart';
import 'package:classes/widgets/grid_unit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/home/schedule_entity.dart';
import '../../res/colours.dart';

//"https://pass.zwu.edu.cn/cas/login?service=https://jw.zwu.edu.cn/sso/drvfivelogin"
class HomePage extends BasePage {
  HomePage({super.key});

  final logic = Get.put(HomeLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<HomeLogic>(
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colours.white,
            title: Text("第${logic.currentIndex + 1}周",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.65))),
            centerTitle: false,
            actions: [
              const Icon(Icons.add).tap(() => Get.toNamed(Routes.homeAdd)),
              const Icon(Icons.more_vert_rounded).tap(() => Get.bottomSheet(showMore(),barrierColor: Colors.transparent))
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: logic.pageController,
                  onPageChanged: (index) {
                    logic.currentIndex = index;
                  },
                  children: List.generate(logic.weekSchedule.length, (index) {
                    return weekLessons(logic.weekSchedule[index]);
                  }),
                ),
              ),
            ],
          )
        );
    });
  }

  Widget weekLessons(List<List<Schedule>> list) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 20, child: Text("${DateTime.now().month >= 10?DateTime.now().month:" ${DateTime.now().month}"}月")),
            Expanded(child: GridUnit(child: Text("一"))),
            Expanded(child: GridUnit(child: Text("二"))),
            Expanded(child: GridUnit(child: Text("三"))),
            Expanded(child: GridUnit(child: Text("四"))),
            Expanded(child: GridUnit(child: Text("五"))),
            Expanded(child: GridUnit(child: Text("六"))),
            Expanded(child: GridUnit(child: Text("日")))
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                          12, (index) => GridUnit(child: Text("${index + 1}")))
                  ),
                ),
                Expanded(
                  child: Column(
                    children: List.generate(list.length, (index) => ClassSingleDay(
                      classes: list[index]
                    )),
                  ),
                )
                // Expanded(
                //   child: ClassSingleDay(classes: [
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 3, end: 4),
                //     HomeClassSingeDayEntity(className: "应用物理", start: 5, end: 7),
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 9, end: 12)
                //   ]),
                // ),
                // Expanded(
                //   child: ClassSingleDay(classes: [
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 1, end: 2),
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 5, end: 7),
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 10, end: 11)
                //   ]),
                // ),
                // Expanded(
                //   child: ClassSingleDay(classes: [
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 3, end: 4),
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 5, end: 7),
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 10, end: 12)
                //   ]),
                // ),
                // Expanded(
                //   child: ClassSingleDay(classes: [
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 3, end: 4),
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 5, end: 7),
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 8, end: 10)
                //   ]),
                // ),
                // Expanded(
                //   child: ClassSingleDay(classes: [
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 2, end: 4),
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 5, end: 7),
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 10, end: 12)
                //   ]),
                // ),
                // Expanded(
                //   child: ClassSingleDay(classes: [
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 3, end: 4),
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 5, end: 7),
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 10, end: 12)
                //   ]),
                // ),
                // Expanded(
                //   child: ClassSingleDay(classes: [
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 3, end: 4),
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 5, end: 7),
                //     HomeClassSingeDayEntity(className: "形势与政策", start: 10, end: 12)
                //   ]),
                // ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget showMore() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10
          )
        ]
      ),
      child: BottomSheet(
          elevation: 40,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16))
          ),
          constraints: BoxConstraints(
              maxWidth: Get.width, maxHeight: Get.height * 0.25),
          builder: (context) =>
              GetBuilder<HomeLogic>(
                  builder: (logic) {
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 16),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("设置当前周"),
                                Row(
                                  children: [
                                    Text("${logic.weekIndex}"),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        trackHeight: 10,
                                        thumbColor: Colours.white,
                                        overlayColor: Colors.transparent,
                                        activeTrackColor: Colors.grey.withOpacity(0.3),
                                        inactiveTrackColor: Colors.grey.withOpacity(0.7),
                                        thumbShape: const RoundSliderThumbShape(
                                          enabledThumbRadius: 10,
                                          elevation: 10,
                                          pressedElevation: 16
                                        ),
                                        trackShape: const RoundedRectSliderTrackShape(),
                                      ),
                                      child: Slider(
                                        value: logic.weekIndex.toDouble(),
                                        min: 1,
                                        max: 14,
                                        divisions: 13,
                                        onChanged: (value) =>
                                        logic.weekIndex = value.toInt(),
                                        onChangeEnd: (value) {
                                          SpUtils.tableSet = TableSet(
                                            tableId: SpUtils.tableSet?.tableId,
                                            userId: UserState.info?.userId,
                                            currentWeek: value.toInt(),
                                            lessonNum: SpUtils.tableSet?.lessonNum,
                                            totalWeek: SpUtils.tableSet?.totalWeek);
                                          logic.pageController.animateToPage(
                                                value.toInt() - 1,
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                curve: Curves.linear);
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("设置节数"),
                                Icon(size: 20, Icons.arrow_forward_ios)
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("切换课表"),
                                Icon(size: 20, Icons.arrow_forward_ios)
                              ],
                            ),
                          ),
                          // ExpansionTile(
                          //   title: Text("切换课表",style: TextStyle(fontSize: 12)),
                          //   collapsedBackgroundColor: Colors.red,
                          //
                          //   // shape: RoundedRectangleBorder(
                          //   //     side: BorderSide(color: Colors.black,width: 1),
                          //   //     borderRadius: BorderRadius.circular(8)
                          //   // ),
                          //   // collapsedShape: RoundedRectangleBorder(
                          //   //     side: BorderSide(color: Colors.black,width: 1),
                          //   //     borderRadius: BorderRadius.circular(8)
                          //   // ),
                          //   trailing: Row(
                          //       mainAxisSize: MainAxisSize.min,
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Text("大三下"),
                          //       Icon(Icons.keyboard_arrow_down_rounded)
                          //     ],
                          //   ),
                          //   childrenPadding: EdgeInsets.symmetric(horizontal: 10),
                          //   children: List.generate(5, (index) => Container(
                          //     height: 40,
                          //     width: Get.width,
                          //     decoration: BoxDecoration(
                          //         border: Border(top: BorderSide(color: Colors.black,width: 1))
                          //     ),
                          //     alignment: Alignment.centerLeft,
                          //       child: ListTile(
                          //         title: Text("大三下"),
                          //         selectedColor: Colors.white,
                          //         selectedTileColor: Colors.red,
                          //         selected: logic.tableIndex == index,
                          //         onTap: () => logic.tableIndex = index,
                          //       ),
                          //   )),
                          // ),
                        ],
                      ),
                    );
                  }
              ), onClosing: () {  },
      ),
    );
  }
}

class FullWidthTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - (trackHeight ?? 0)) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight ?? 0);
  }
}
