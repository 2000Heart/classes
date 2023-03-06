import 'package:classes/res/utils.dart';
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
          LinearGradient(colors: colors,begin: Alignment.topLeft,end: Alignment.bottomRight).createShader(bounds),
      child: child.tap(onTap),
    );
  }
}
