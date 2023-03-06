import 'dart:core';
import 'package:flutter/material.dart';
import 'clipped_view.dart';
import 'bottom_bar.dart';
import 'rotation_3d.dart';

class NavbarButton extends StatefulWidget {
  final BottomBarItemData data;
  final bool isSelected;
  final VoidCallback onTap;

  const NavbarButton(this.data, this.isSelected, {super.key, required this.onTap });

  @override
  _NavbarButtonState createState() => _NavbarButtonState();
}

class _NavbarButtonState extends State<NavbarButton> with SingleTickerProviderStateMixin {
  late AnimationController _iconAnimController;
  bool? _wasSelected;
  double _animScale = 1;

  @override
  void initState() {
    int duration = (350 / _animScale).round();
    _iconAnimController = AnimationController(
      duration: Duration(milliseconds: duration),
      vsync: this,
    );
    Tween<double>(begin: 0, end: 1).animate(_iconAnimController)
      .addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _startAnimIfSelectedChanged(widget.isSelected);
    var content = Row(
      children: <Widget>[
        Rotation3d(
          rotationY: 180 * _iconAnimController.value,
          child: Icon(
            widget.data.icon,
            size: 24,
            color: widget.isSelected ? Colors.white : Color(0xffcccccc),
          ),
        ),
        SizedBox(width: 12),
        Text(
          widget.data.title,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: AnimatedContainer(
          alignment: Alignment.center,
          width: widget.isSelected ? widget.data.width : 56,
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(12),
          duration: Duration(milliseconds: (700 / _animScale).round()),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: widget.isSelected ?widget.data.selectedColor:[Colors.white,Colors.white]),
            borderRadius: const BorderRadius.all(Radius.circular(26)),
          ),
          child: ClippedView(
            child: content,
          ),
        ),
      ),
    );
  }

  void _startAnimIfSelectedChanged(bool isSelected) {
    if (_wasSelected != widget.isSelected) {
      widget.isSelected ? _iconAnimController.forward() : _iconAnimController.reverse();
    }
    _wasSelected = widget.isSelected;
  }
}