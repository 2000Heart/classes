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