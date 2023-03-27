import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:classes/model/user_entity.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/sp_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../http/api.dart';
import 'date_utils_extension.dart';


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
  static Future<String?> cropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      compressQuality: 50,
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [CropAspectRatioPreset.square]
          : [CropAspectRatioPreset.square],
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: '裁剪',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black.withOpacity(0.8),
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: true),
        IOSUiSettings(
            title: '',
            aspectRatioPickerButtonHidden: true,
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false)
      ],
    );
    return croppedFile?.path;
  }

  static Future pickPhotoFormCamera({int imageQuality = 50}) async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if(file?.path == null) return null;
    String? cropped = await cropImage(file!.path);
    if(cropped == null) return null;
    var result = await Api.uploadImage(cropped);
    if(result != null) SpUtils.loginAuth = result;
  }

  static Future pickPhotoFormGallery({int imageQuality = 50}) async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if(file?.path == null) return;
    var cropped = await cropImage(file!.path);
    if(cropped == null) return;
    var result = await Api.uploadImage(cropped);
    if(result != null) SpUtils.loginAuth = result;
  }

  // static Future<List<AssetEntity>?> pickPhotoFormGallary(
  //     {int maxPhotos = 1}) async {
  //   return await AssetPicker.pickAssets(Get.context!,
  //       pickerConfig: AssetPickerConfig(
  //           maxAssets: maxPhotos,
  //           themeColor: Colours.main_color,
  //           requestType: RequestType.image,
  //           textDelegate: AssetPickerTextDelegate()));
  // }
}

//日期格式化
String formatTime(String time) {
  int interval = DateTime.now().millisecondsSinceEpoch - DateTime.parse(time).millisecondsSinceEpoch;
  if (interval < 60 * 1000) {
    interval = interval ~/ 1000;
    return '刚刚';
  } else if (interval < 60 * 60 * 1000) {
    interval = interval ~/ 60000;
    return '$interval分钟前';
  } else if (interval < 24 * 60 * 60 * 1000) {
    interval = interval ~/ 3600000;
    return '$interval小时前';
  } else if (interval < 3 * 24 * 60 * 60 * 1000) {
    interval = interval ~/ (3600000 * 24);
    return '$interval天前';
  } else {
    return DateUtilsExtension.formatDateString(time, 'MM-dd HH:mm');
  }
}

int getCurrentMonthDays(int year, int month) {
  if (month == 2) {
    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) {
      return 29;
    } else {
      return 28;
    }
  } else if (month == 1 ||
      month == 3 ||
      month == 5 ||
      month == 7 ||
      month == 8 ||
      month == 10 ||
      month == 12) {
    return 31;
  } else {
    return 30;
  }
}

String formDuration(List<int> duration){
  List<String> list = [""];
  var item = 0;
  list[item] = duration[0].toString();
  for(var i=0;i< duration.length;i++){
    var j = i+1>=duration.length?i=duration.length-1:i+1;
    if(duration[j] - duration[i] > 1 || i==duration.length-1){
      if(list[item] != duration[i].toString())list[item] += "-${duration[i]}";
      item += 1;
      if(i!=duration.length-1)list.add(duration[j].toString());
    }
  }
  return list.join(",");
}

String weekZh(int day){
  List<String> weekday = ["一","二","三","四","五","六","日"];
  return weekday[day -1];
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
      substring((length-len)>0?(length-len):0, length);
}

extension WidgetEx1 on Widget {
  SizedBox sized({double? width, double? height}) =>
    SizedBox(width: width, height: height, child: this);

  GestureDetector tap(void Function()? fn) =>
    GestureDetector(onTap: fn, behavior: HitTestBehavior.translucent, child: this);

  rounded(double r) => Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(r)),
    clipBehavior: Clip.hardEdge,
    child: this);

  Container get center => Container(
    alignment: Alignment.center,
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

extension Exten on List<Widget>{
  Widget formLine() => SizedBox(
    height: 40,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: this,
    ),
  );
}

