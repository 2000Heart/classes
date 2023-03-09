
import 'package:classes/utils/utils.dart';
import 'package:flutter/material.dart';

class ColourfulWrap extends StatelessWidget {
  const ColourfulWrap({Key? key, required this.colors, required this.child, this.onTap}) : super(key: key);

  final List<Color> colors;
  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          LinearGradient(colors: colors,begin: Alignment.centerLeft,end: Alignment.centerRight).createShader(bounds),
      child: child.tap(onTap),
    );
  }
}
