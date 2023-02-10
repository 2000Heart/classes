import 'package:classes/model/home/home_class_single_day_entity.dart';

extension IntExtension on HomeClassSingeDayEntity{
  bool get isUseless{
    if(start == null || end == null || className == null){
      return true;
    }else{
      return false;
    }
  }
}

extension StringExtesion on String?{
  bool get hasValue => this != null && this != "";
}