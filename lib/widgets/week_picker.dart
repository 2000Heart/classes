

import 'dart:developer';

import 'package:classes/utils/sp_utils.dart';
import 'package:classes/utils/utils.dart';
import 'package:classes/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeekPicker extends StatefulWidget {
  const WeekPicker({Key? key}) : super(key: key);

  @override
  State<WeekPicker> createState() => _WeekPickerState();
}

class _WeekPickerState extends State<WeekPicker> {
  late List<int> weeks = List.generate(SpUtils.tableSet?.totalWeek ?? 0, (index) => index+1);
  late List<int> result = List.generate(SpUtils.tableSet?.totalWeek ?? 0, (index) => index+1);
  late List<bool> choose = List.generate(SpUtils.tableSet?.totalWeek ?? 0, (index) => true);
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
                  NormalButton.rect(text: "确认", width: 80,height: 35, onTap: () => Get.back(result: result))
                ],
              ),
              Container(height: 16),
              Wrap(
                runSpacing: 10,spacing: 10,
                children: weeks.map((e) => item(e)).toList(),
              )
            ],
          ),
        );
      },
    );
  }

  Widget item(int text){
    return GestureDetector(
      onTap: (){
        setState(() {
          choose[text - 1]?result.remove(text):result.insert(result.indexOf(text-1)+1, text);
          choose[text - 1] = !choose[text - 1];
        });
      },
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4,
              blurStyle: BlurStyle.solid,
              offset: Offset(0, 1)
          )],
          color: choose[text - 1]?Colors.white:Colors.grey,
        ),
        child: Text(text.toString())
      ),
    );
  }
}
