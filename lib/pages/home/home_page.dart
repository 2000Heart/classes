import 'package:classes/base/base_page.dart';
import 'package:classes/logic/home/home_logic.dart';
import 'package:classes/model/home/home_class_single_day_entity.dart';
import 'package:classes/res/utils.dart';
import 'package:classes/widgets/grid_unit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//"https://pass.zwu.edu.cn/cas/login?service=https://jw.zwu.edu.cn/sso/drvfivelogin"
class HomePage extends BasePage {
  HomePage({super.key});

  final logic = Get.put(HomeLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<HomeLogic>(builder: (logic) {
      return Scaffold(
          body: Column(
            children: [
              Row(
                children: [
                  Text("第${logic.currentIndex + 1}周"),
                  Icon(Icons.more_vert_rounded).tap(() => showMore(context))
                ],
              ),
              Expanded(
                child: PageView(
                  controller: logic.pageController,
                  onPageChanged: (index) {
                    logic.currentIndex = index;
                  },
                  children: List.generate(14, (index) {
                    return weekLessons();}),
                ),
              ),
            ],
          )
      );
    });
  }

  Widget weekLessons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            SizedBox(width: 20, child: Text("12月")),
            Expanded(child: GridUnit(child: Text("一"))),
            Expanded(child: GridUnit(child: Text("二"))),
            Expanded(child: GridUnit(child: Text("三"))),
            Expanded(child: GridUnit(child: Text("四"))),
            Expanded(child: GridUnit(child: Text("五"))),
            Expanded(child: GridUnit(child: Text("六"))),
            Expanded(child: GridUnit(child: Text("日"))),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Row(
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
                ClassSingleDay(classes: [
                  HomeClassSingeDayEntity(className: "形势与政策", start: 3, end: 9)
                ]),
                Expanded(
                  child: Column(
                    children: const [
                      GridUnit(child: Text("面向对象编程"), color: Colors.green, num: 4)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: const [
                      GridUnit(child: Text("英语课"), color: Colors.yellow, num: 4)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: const [
                      GridUnit(child: Text("英语课"), color: Colors.blue, num: 4)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: const [
                      GridUnit(child: Text("英语课"), color: Colors.red, num: 4)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: const [
                      GridUnit(child: Text("英语课"), color: Colors.purple, num: 4)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: const [
                      GridUnit(child: Text("英语课"), color: Colors.grey, num: 4)
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  showMore(context){
    return showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),topRight: Radius.circular(10))
      ),
      constraints: BoxConstraints(
        maxWidth: Get.width, maxHeight: Get.height * 0.3),
      builder: (context) =>
        GetBuilder<HomeLogic>(
          builder: (logic) {
            return Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    height: 50,
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
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 10
                                ),
                                trackShape: RoundedRectSliderTrackShape(),
                              ),
                              child: Slider(
                                value: logic.weekIndex.toDouble(),
                                min: 1,
                                max: 14,
                                divisions: 13,
                                onChanged: (value) => logic.weekIndex = value.toInt(),
                                onChangeEnd: (value) => logic.pageController.animateToPage(value.toInt() - 1,duration: Duration(milliseconds: 200),curve: Curves.linear),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
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
        )
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
    // 让轨道宽度等于 Slider 宽度
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight ?? 0);
  }
}
