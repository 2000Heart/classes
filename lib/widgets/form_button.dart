import 'package:flutter/material.dart';

class NormalButton extends StatefulWidget {
  const NormalButton({Key? key, required this.onTap, required this.child}) : super(key: key);

  final GestureTapCallback onTap;
  final Widget child;

  @override
  State<NormalButton> createState() => _NormalButtonState();
}

class _NormalButtonState extends State<NormalButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10)
          ),
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          child: widget.child),
    );
  }
}
