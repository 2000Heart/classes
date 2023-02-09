import 'package:classes/model/home/home_class_single_day_entity.dart';

extension IntExtension on HomeClassSingeDayEntity{
  bool isUseless(){
    if(start == null || end == null){
      return true;
    }else{
      return false;
    }
  }
}
