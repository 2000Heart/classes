import 'package:classes/base/base_controller.dart';
import 'package:classes/http/lessons_api.dart';
import 'package:classes/model/lessons/check_entity.dart';
import 'package:classes/model/lessons/check_history_entity.dart';

class MyReviewLogic extends BaseLogic{
  List<CheckHistory>? _checkList;

  List<CheckHistory> get checkList => _checkList ?? [];

  Future requestData() async{
    _checkList = await LessonAPI.getCheckHistory();
    update();
  }
}