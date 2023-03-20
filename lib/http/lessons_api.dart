import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/model/lessons/check_entity.dart';
import 'package:classes/model/lessons/lesson_entity.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/sp_utils.dart';

import '../model/error_entity.dart';
import 'dio_utils.dart';

class LessonAPI {

  static Future createCheck(Json check) async {
    final data = check;
    final result = await DioUtils.post('/lesson/check/create', params: data);
    if (result.statusCode == 200) {
      return Schedule.fromJson(result.data["d"]);
    } else {
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }

  static Future getCheck(int infoId) async {
    final data = {
      "infoId": infoId,
      "userId": UserState.info?.userId
    };
    final result = await DioUtils.post('/lesson/check/query', params: data);
    if (result.statusCode == 200) {
      return Check.fromJson(result.data["d"]);
    } else {
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }

  static Future getCheckList() async {
    final data = {"userId": UserState.info?.userId};
    final result = await DioUtils.post('/lesson/check/queryList', params: data);
    if (result.statusCode == 200) {
      List<Check> data = result.data['d']
          .map<Check>((e) => Check.fromJson(e)).toList();
      return data;
    } else {
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }

  static Future createLesson(Json lesson) async {
    final data = lesson;
    final result = await DioUtils.post('/lesson/create', params: data,showLoading: true);
    if (result.statusCode == 200) {
      return Lesson.fromJson(result.data["d"]);
    } else {
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }

  static Future getLesson(int infoId) async {
    final data = {
      "infoId": infoId,
      "userId": UserState.info?.userId
    };
    final result = await DioUtils.post('/lesson/query', params: data);
    if (result.statusCode == 200) {
      return Lesson.fromJson(result.data["d"]);
    } else {
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }

  static Future getLessonList() async {
    final data = {"userId": UserState.info?.userId,"userType": UserState.info?.userType};
    final result = await DioUtils.post('/lesson/query', params: data);
    if (result.statusCode == 200) {
      List<Lesson> data = result.data['d']
          .map<Lesson>((e) => Lesson.fromJson(e)).toList();
      return data;
    } else{
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }

  static Future createLessons(List<Json> list) async{
    final data = {"d":list};
    await DioUtils.post("/lesson/create/all", params: data, showLoading: true);
  }
}