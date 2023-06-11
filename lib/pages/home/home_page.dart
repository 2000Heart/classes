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
import 'package:classes/widgets/single_picker.dart';
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
      initState: (state) => logic.requestData(),
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
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colours.PINK,Colours.BLUE_LIGHT],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)
            ),
            child: Column(
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
            ),
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
            Container(width: 20, height: 50, alignment: Alignment.center, child: Text("${DateTime.now().month >= 10?DateTime.now().month:" ${DateTime.now().month}"}月")),
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
                        UserState.tableSet?.lessonNum ?? 12, (index) => GridUnit(child: Text("${index + 1}")))
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(list.length, (index) => Expanded(
                      child: ClassSingleDay(
                        classes: list[index]
                      ),
                    )),
                  ),
                )
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
          enableDrag: false,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16))
          ),
          constraints: BoxConstraints(
              maxWidth: Get.width),
          builder: (context) =>
              GetBuilder<HomeLogic>(
                  builder: (logic) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24,top: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                                        max: (SpUtils.tableSet?.totalWeek ?? 18).toDouble(),
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
                                Text("设置总周数"),
                                Icon(size: 20, Icons.arrow_forward_ios)
                              ],
                            ),
                          ).tap(() async{
                            Map<int,dynamic>? num = await Get.bottomSheet(SinglePicker(list: List.generate(25, (index) => index+1), initIndex: (SpUtils.tableSet?.totalWeek ?? 1)-1));
                            if(num != null) {
                              var table = SpUtils.tableSet;
                              table?.totalWeek = num.values.first;
                              if((table?.totalWeek ?? 0) < (table?.currentWeek ?? 0)) {
                                table?.currentWeek = table.totalWeek;
                                logic.weekIndex = table?.currentWeek ?? 0;
                              }
                              SpUtils.tableSet = table;
                              Future.delayed(Duration(milliseconds: 300)).then((value) => logic.requestData());
                            }
                          }),
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
                            ).tap(() async{
                              Map<int,dynamic>? num = await Get.bottomSheet(SinglePicker(list: List.generate(20, (index) => index+1), initIndex: (SpUtils.tableSet?.lessonNum ?? 1)-1));
                              if(num != null) {
                                var table = SpUtils.tableSet;
                                table?.lessonNum = num.values.first;
                                SpUtils.tableSet = table;
                                Future.delayed(Duration(milliseconds: 300)).then((value) => logic.requestData());
                              }
                            }),
                          )
                        ],
                      ),
                    );
                  }
              ), onClosing: () { },
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
