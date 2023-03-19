
import 'package:classes/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'button.dart';

class UnitPicker extends StatefulWidget {
  const UnitPicker({Key? key}) : super(key: key);

  @override
  State<UnitPicker> createState() => _UnitPickerState();
}

class _UnitPickerState extends State<UnitPicker> {
  List<String> week = ["周一","周二","周三","周四","周五","周六","周日"];
  List<String> lesson = List.generate(10, (index) => "第${index+1}节");
  int selectWeek = 1;
  int startUnit = 1;
  int endUnit = 1;
  FixedExtentScrollController start = FixedExtentScrollController();
  FixedExtentScrollController end = FixedExtentScrollController();
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      elevation: 40,
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(16))
      ),
      constraints: BoxConstraints(
          maxWidth: Get.width),
      onClosing: () {  },
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10,bottom: 30,top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NormalButton.rect(text: "取消", width: 80,height: 35,onTap: Get.back),
                  NormalButton.rect(text: "确认", width: 80,height: 35,
                    onTap: () => Get.back(result: [selectWeek,startUnit,endUnit]))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: CupertinoPicker(
                        itemExtent: 30,
                        onSelectedItemChanged: (position) => selectWeek = position+1,
                        children: week.map((e) => Center(child: Text(e,style: TextStyle(fontSize: 17)))).toList()),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: CupertinoPicker(
                        scrollController: start,
                        itemExtent: 30,
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
                        children: lesson.map((e) => Center(child: Text(e,style: TextStyle(fontSize: 17)))).toList()),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: CupertinoPicker(
                        scrollController: end,
                        itemExtent: 30,
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
                        children: lesson.map((e) => Center(child: Text(e,style: TextStyle(fontSize: 17)))).toList()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
