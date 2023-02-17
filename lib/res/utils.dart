import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static String getImgPath(String name) {
    return 'assets/images/$name';
  }

  static String getFilePath(String name) {
    return 'assets/files/$name';
  }

  static String generateRandomString(int length) {
    final random = math.Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();
    return randomString;
  }

  //阅读人数格式化
  static String formatReadNum(int num) {
    if (num < 9999) {
      return num.toString();
    } else {
      num = num ~/ 10000;
      return '$num万+';
    }
  }

  static FutureOr<T?> tryOrNullf<T>(FutureOr<T> Function() fn) async {
    try {
      return await fn();
    } catch (err) {
      log("$err");
      return null;
    }
  }

  static String getFileSize(int length) {
    String size = "";
    //内存转换
    if (length < 0.1 * 1024) {
      size = length.toStringAsFixed(2);
      size = size + "B";
    } else if (length < 0.1 * 1024 * 1024) {
      size = (length / 1024).toStringAsFixed(2);
      // size = size.toStringAsFix
      size = size + "KB";
    } else if (length < 0.1 * 1024 * 1024 * 1024) {
      size = (length / (1024 * 1024)).toStringAsFixed(2);
      print(size.indexOf("."));
      size = size + "MB";
    } else {
      size = (length / (1024 * 1024 * 1024)).toStringAsFixed(2);
      size = size + "GB";
    }
    return size;
  }

  static String _resolvePath(String path, {String? subpath}) {
    final topPath = {
      '/home': '首页',
      '/match': '比赛',
      '/expert': "推荐",
      '/data': '数据',
      '/my': '我的'
    };
    return topPath[path] ?? path;
  }
}

typedef FilterFn<T> = bool Function(T item);

extension ListEx1<T> on List<T> {
  List<T> filter(FilterFn<T> fn) {
    List<T> l = [];
    for (var element in this) {
      if (fn(element)) {
        l.add(element);
      }
    }
    return l;
  }

  List<T>? filterOrNull(FilterFn<T> fn) {
    final l = filter(fn);
    if (l.isEmpty) {
      return null;
    }
    return l;
  }
}

extension StringExtension on String? {
  bool get valuable => this != null && this!.isNotEmpty;
}

extension StringEx1 on String {
  String lastString(int len) =>
      substring((length - len) > 0 ? (length - len) : 0, length);
}

extension WidgetEx1 on Widget {
  SizedBox sized({double? width = null, double? height = null}) =>
      SizedBox(width: width, height: height, child: this);
  GestureDetector tap(void Function()? fn) =>
      GestureDetector(onTap: fn, behavior: HitTestBehavior.opaque, child: this);
  rounded(double r) => Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(r)),
      clipBehavior: Clip.hardEdge,
      child: this);
}

extension FontWeightEx1 on FontWeight {
  static FontWeight get qxbBold => FontWeight.w600;
  static FontWeight get qxbNormal => FontWeight.w400;
  static FontWeight get qxbMedium => FontWeight.w500;
}

extension StateEx1 on State {
  update() {
    if (!mounted) {
      return;
    }
    setState(() {});
  }
}

extension NullCheck on String? {
  bool get isNullOrEmpty => this == null || this == '';
}

extension TextWidth on Text {
  Container wrapTextWidth(double fontSize,FontWeight fontWeight) {
    var tp = TextPainter(textDirection: TextDirection.ltr,text: TextSpan(text: data,style: TextStyle(fontSize: fontSize,fontWeight: fontWeight)))..layout();
    return Container(
      width: tp.width,
      child: this
    );
  }
}
