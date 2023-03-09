import 'package:classes/model/home/schedule_entity.dart';

extension IntExtension on Schedule{
  bool get isUseless{
    if(startUnit == null || endUnit == null || lessonName == null){
      return true;
    }else{
      return false;
    }
  }
}

extension StringExtesion on String?{
  bool get hasValue => this != null && this != "";
}