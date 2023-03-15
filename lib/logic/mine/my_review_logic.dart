import 'package:classes/base/base_controller.dart';
import 'package:classes/http/lessons_api.dart';
import 'package:classes/model/lessons/check_entity.dart';

class MyReviewLogic extends BaseLogic{
  List<Check>? _checkList;


  List<Check> get checkList => _checkList ?? [];

  Future requestData() async{
    _checkList = await LessonAPI.getCheckList();
  }
}