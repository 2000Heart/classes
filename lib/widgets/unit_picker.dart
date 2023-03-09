
import 'package:classes/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnitPicker extends StatefulWidget {
  const UnitPicker({Key? key}) : super(key: key);

  @override
  State<UnitPicker> createState() => _UnitPickerState();
}

class _UnitPickerState extends State<UnitPicker> {
  List<String> week = ["周一","周二","周三","周四","周五","周六","周日"];
  List<String> lesson = List.generate(10, (index) => "第${index+1}节");
  int selectWeek = 0;
  int startUnit = 0;
  int endUnit = 0;
  FixedExtentScrollController start = FixedExtentScrollController();
  FixedExtentScrollController end = FixedExtentScrollController();
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {  },
      enableDrag: false,
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("取消").tap(() => Get.back()),
                Text("确认").tap(() => Get.back(result: [selectWeek,startUnit,endUnit]))
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 40,
                      onSelectedItemChanged: (position) => selectWeek = position+1,
                      children: week.map((e) => Center(child: Text(e))).toList()),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: start,
                      itemExtent: 40,
                      onSelectedItemChanged: (position) {
                        setState(() {
                          startUnit = position+1;
                        });
                        if(startUnit > endUnit) {
                          end.animateToItem(
                            position, duration: const Duration(milliseconds: 200),
                            curve: Curves.linear);
                        }
                      },
                      children: lesson.map((e) => Center(child: Text(e))).toList()),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: end,
                      itemExtent: 40,
                      onSelectedItemChanged: (position) {
                        setState(() {
                          endUnit = position+1;
                        });
                        if(endUnit < startUnit) {
                          start.animateToItem(
                            position, duration: const Duration(milliseconds: 200),
                            curve: Curves.linear);
                        }
                      },
                      children: lesson.map((e) => Center(child: Text(e))).toList()),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
