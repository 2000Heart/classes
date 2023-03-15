import 'package:classes/base/base_controller.dart';
import 'package:classes/http/lessons_api.dart';

import '../../model/lessons/lesson_entity.dart';

class LessonsLogic extends BaseLogic{
  List<Lesson>? _lessons;

  List<Lesson> get lessons => _lessons ?? [];


  Future requestData() async{
    _lessons = await LessonAPI.getLessonList();
  }
}