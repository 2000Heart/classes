import 'package:classes/model/home/home_class_single_day_entity.dart';
import 'package:classes/pages/home/home_detail_page.dart';
import 'package:classes/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridUnit extends StatelessWidget{
  const GridUnit({super.key, required this.child, this.num = 1, this.color = Colors.white});

  final Widget child;
  final int num;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 50,
      height: 50.0*num,
      alignment: Alignment.center,
      child: child,
    );
  }

}

class ClassSingleDay extends StatelessWidget{
  const ClassSingleDay({super.key, this.color = Colors.red, required this.classes});

  final List<HomeClassSingeDayEntity> classes;
  final Color color;

  List<Widget> formClasses(){
    List<Widget> list = [];
    for(var i = 0;i < classes.length;i++){
      if(!classes[i].isUseless) {
        list.add(
            GestureDetector(
              onTap: () => Get.dialog(HomeDetailPage(),arguments: classes[i].classId),
              child: Container(
                color: color,
                width: 50,
                height: 50.0 * ((classes[i].end ?? 0) - (classes[i].start ?? 0) + 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    classes[i].className.hasValue?
                      Text(classes[i].className!,textAlign: TextAlign.center):Container(),
                    if(classes[i].classroom.hasValue)Text(classes[i].classroom!,textAlign: TextAlign.center),
                    if(classes[i].teacher.hasValue)Text(classes[i].teacher!,textAlign: TextAlign.center),
                  ],
                ),
              ),
            )
        );
      }
      if((classes[0].start ?? 0) > 1){
        list.insert(0,
            Container(
              color: Colors.transparent,
              width: 50,
              height: 50.0 * ((classes[0].start ?? 0) - 1),
              alignment: Alignment.center,
            )
        );
      }
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

}