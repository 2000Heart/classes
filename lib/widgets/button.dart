import 'package:flutter/material.dart';

import '../res/colours.dart';

class NormalButton extends StatelessWidget {
  const NormalButton({Key? key, this.onTap, required this.text, this.textStyle, this.width, this.height, this.type}) : super(key: key);

  final Function()? onTap;
  final String text;
  final TextStyle? textStyle;
  final BoxShape? type;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 45,
        width: width ?? 120,
        decoration: BoxDecoration(
          shape: type ?? BoxShape.rectangle,
          gradient: const LinearGradient(
            tileMode: TileMode.clamp,
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
            stops: [0.4, 1],
            colors: [Colors.black, Colors.black54],
          ),
          borderRadius: BorderRadius.circular(50),
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
