import 'package:flutter/material.dart';

import '../res/colours.dart';

class NormalButton extends StatelessWidget {
  const NormalButton({Key? key,
    this.onTap,
    required this.text,
    this.textStyle,
    this.width,
    this.height,
    this.type,
    this.size,
    this.radius}) : super(key: key);

  const NormalButton.circle({Key? key,
    this.onTap,
    required this.text,
    this.textStyle,
    this.type = BoxShape.circle,
    this.width,
    this.height,
    this.size,
    this.radius}):super(key: key);

  const NormalButton.rect({Key? key,
    this.onTap,
    required this.text,
    this.textStyle,
    this.type = BoxShape.rectangle,
    this.width,
    this.height,
    this.size,
    this.radius=4}):super(key: key);

  final Function()? onTap;
  final String text;
  final TextStyle? textStyle;
  final BoxShape? type;
  final double? width;
  final double? height;
  final double? size;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: size ?? height ?? 45,
        width: size ?? width ?? 120,
        decoration: BoxDecoration(
          shape: type ?? BoxShape.rectangle,
          // color: Colors.black,
          gradient: const LinearGradient(
            tileMode: TileMode.clamp,
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
            stops: [0.7, 1],
            colors: [Colors.black, Colors.black54],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 20,
              offset: Offset(1.0, 9.0),
            ),
          ],
          borderRadius: BorderRadius.circular(radius ?? 50),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textStyle?.color ?? Colours.YELLOW,
            fontWeight: textStyle?.fontWeight ?? FontWeight.w700,
            fontSize: textStyle?.fontSize ?? 14,
          ),
        ),
      ),
    );
  }
}
