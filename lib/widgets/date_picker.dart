
import 'package:classes/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'button.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key, this.showDay=true}) : super(key: key);

  final bool showDay;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  List<int> days = List.generate(
    getCurrentMonthDays(DateTime.now().year, DateTime.now().day),
    (index) => index+1);
  int dayIndex = 0;
  int hour = 0;
  int minute = 0;
  List<DateTime> daysList = Get.arguments;

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
                NormalButton.rect(text: "确认", width: 80,height: 35, onTap: () => Get.back(result: daysList[dayIndex].copyWith(hour: hour,minute: minute)))
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(widget.showDay)Expanded(
                  child: SizedBox(
                    height: 200,
                    child: CupertinoPicker(
                      itemExtent: 30,
                      onSelectedItemChanged: (position) => setState(() {dayIndex = position;}),
                      children: daysList.map((e) => Center(child: Text("${e.day}日"))).toList()),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: CupertinoPicker(
                      itemExtent: 30,
                      onSelectedItemChanged: (position) => setState(() {
                          hour = position+1;
                        }),
                      children: List.generate(24, (index) => Center(child: Text("${index+1}点")))),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: CupertinoPicker(
                      itemExtent: 30,
                      onSelectedItemChanged: (position) => setState(() {
                          minute = position+1;
                        }),
                      children: List.generate(60, (index) => Center(child: Text(index<9?"0${index+1}分":"${index+1}分")))),
                  ),
                ),
              ],
            ),
          ])
        );
      },
    );
  }
}