import 'package:classes/model/home/home_class_single_day_entity.dart';
import 'package:flutter/material.dart';

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
      if(classes[i].start != null && classes[i].end != null) {
        list.add(
            Container(
              color: color,
              width: 50,
              height: 50.0 * ((classes[i].end ?? 0) - (classes[i].start ?? 0) + 1),
              alignment: Alignment.center,
              child: Text(classes[i].className ?? ''),
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
      children: formClasses(),
    );
  }

}