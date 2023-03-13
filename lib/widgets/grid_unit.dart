import 'dart:math';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/pages/home/home_detail_page.dart';
import 'package:classes/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/colours.dart';

class GridUnit extends StatelessWidget{
  const GridUnit({super.key, required this.child, this.num = 1, this.color = Colors.white});

  final Widget child;
  final int num;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 50.0*num,
      alignment: Alignment.center,
      child: child,
    );
  }

}

class ClassSingleDay extends StatelessWidget{
  const ClassSingleDay({super.key, required this.classes});

  final List<Schedule> classes;

  List<Widget> formClasses(context){
    List<Widget> list = [];
    if(classes.isNotEmpty){
      for(var i = 0;i < classes.length;i++) {
        if (!classes[i].isUseless) {
          var colorIndex = int.parse(classes[i].userId.toString().substring(classes[i].userId.toString().length-2));
          list.add(
              Container(
                color: Colors.transparent,
                height: 50.0 * ((classes[i].startUnit ?? 0) -
                    (list.isNotEmpty ? (classes[i - 1].endUnit ?? 100) + 1 : 1)),
                alignment: Alignment.center,
              )
          );
          list.add(
              GestureDetector(
                onTap: () => showDetail(context),
                child: Container(
                  width: 50,
                  height: 50.0 *
                      ((classes[i].endUnit ?? 0) - (classes[i].startUnit ?? 0) +
                          1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white70, width: 1),
                      color: Colours.colorList[colorIndex > 8?8:colorIndex].withOpacity(0.9)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      classes[i].lessonName.hasValue ?
                      Text(classes[i].lessonName!, textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white)) : Container(),
                      Container(height: 10),
                      if(classes[i].classroom.hasValue)Text(
                          classes[i].classroom!, textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white)),
                      Container(height: 10),
                      if(classes[i].teacherName.hasValue)Text(
                          classes[i].teacherName!, textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              )
          );
        }
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: formClasses(context),
    );
  }

  showDetail(context){
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      elevation: 40,
      backgroundColor: Colors.white,
      constraints: BoxConstraints(
      maxWidth: Get.width, maxHeight: Get.height * 0.7),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16))),
      builder: (context) => HomeDetailPage()
    );
  }
}