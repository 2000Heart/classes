import 'dart:math';

import 'package:classes/model/home/home_class_single_day_entity.dart';
import 'package:classes/pages/home/home_detail_page.dart';
import 'package:classes/res/extensions.dart';
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

  final List<HomeClassSingeDayEntity> classes;

  List<Widget> formClasses(context){
    List<Widget> list = [];
    for(var i = 0;i < classes.length;i++){
      if(!classes[i].isUseless) {
        list.add(
            GestureDetector(
              onTap: () => showDetail(context),
              child: Container(
                width: 50,
                height: 50.0 * ((classes[i].end ?? 0) - (classes[i].start ?? 0) + 1),
                // margin: EdgeInsets.only(bottom: 5,left: 2,right: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white70,width: 1),
                  color: Colours.colorList[Random.secure().nextInt(Colours.colorList.length - 1)].withOpacity(0.9)
                  // gradient: LinearGradient(colors: [Colours.colorList[Random.secure().nextInt(Colours.colorList.length - 1)],Colours.colorList[Random.secure().nextInt(Colours.colorList.length - 1)]],begin: Alignment.topCenter,end: Alignment.bottomCenter)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    classes[i].className.hasValue?
                      Text(classes[i].className!,textAlign: TextAlign.center,style: TextStyle(color: Colors.white)):Container(),
                    if(classes[i].classroom.hasValue)Text(classes[i].classroom!,textAlign: TextAlign.center),
                    if(classes[i].teacher.hasValue)Text(classes[i].teacher!,textAlign: TextAlign.center),
                  ],
                ),
              ),
            )
        );
      }
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
        backgroundColor: Colors.white,
        constraints: BoxConstraints(maxWidth: Get.width/1.2),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),topRight: Radius.circular(10))
        ),
        builder: (context) => HomeDetailPage()
    );
  }
}