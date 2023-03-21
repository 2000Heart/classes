
import 'package:classes/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key, required this.needSheet, this.showDay=true}) : super(key: key);

  final bool needSheet;
  final bool showDay;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  List<int> days = List.generate(
    getCurrentMonthDays(DateTime.now().year, DateTime.now().day),
    (index) => index+1);
  int day = 0;
  int hour = 0;
  int minute = 0;

  @override
  Widget build(BuildContext context) {
    return widget.needSheet?BottomSheet(
      onClosing: () {  },
      enableDrag: false,
      builder: (BuildContext context) {
        return picker();
      },
    ):picker();
  }

  Widget picker(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("取消").tap(() => Get.back()),
            Text("确认").tap(() => Get.back(result: [day,minute,hour]))
          ],
        ),
        Expanded(
          child: Row(
            children: [
              if(widget.showDay)Expanded(
                child: CupertinoPicker(
                    itemExtent: 40,
                    onSelectedItemChanged: (position) => day = position+1,
                    children: days.map((e) => Center(child: Text("$e日"))).toList()),
              ),
              Expanded(
                child: CupertinoPicker(
                    itemExtent: 40,
                    onSelectedItemChanged: (position) {
                      setState(() {
                        minute = position+1;
                      });
                    },
                    children: List.generate(24, (index) => Center(child: Text("${index+1}点")))),
              ),
              Expanded(
                child: CupertinoPicker(
                    itemExtent: 40,
                    onSelectedItemChanged: (position) {
                      setState(() {
                        hour = position+1;
                      });
                    },
                    children: List.generate(60, (index) => Center(child: Text(index<9?"0${index+1}分":"${index+1}分")))),
              ),
            ],
          ),
        ),
      ],
    );
  }
}