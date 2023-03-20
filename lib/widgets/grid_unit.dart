import 'dart:math';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/pages/home/home_detail_page.dart';
import 'package:classes/res/routes.dart';
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

  List<Widget> formClasses(){
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
                onTap: () => showDetail(classes[i].weekTime ?? 0, classes[i].startUnit ?? 0),
                child: Container(
                  width: 50,
                  height: 50.0 *
                      ((classes[i].endUnit ?? 0) - (classes[i].startUnit ?? 0) +
                          1),
                  padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white70, width: 1),
                      color: Colours.colorList[colorIndex > 8?8:colorIndex].withOpacity(0.9)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(classes[i].lessonName.hasValue)Expanded(
                        child: Text(classes[i].lessonName!, textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                      if(classes[i].classroom.hasValue)Flexible(
                        child: Text(classes[i].classroom!, textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                      if(classes[i].teacherName.hasValue)Flexible(
                        child: Text(
                            classes[i].teacherName!, textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              )
          );
        }
      }
    }else{
      list.add(
          Container(
            color: Colors.transparent,
            width: 50,
            height: 50.0*18,
            alignment: Alignment.center,
          )
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: formClasses(),
    );
  }

  showDetail(int weekTime, int startTime){
    return Get.bottomSheet(
      HomeDetailPage(),
      settings: RouteSettings(
        name: Routes.homeDetail,
        arguments: [weekTime,startTime]),
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      elevation: 40,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16))),
    );
  }
}