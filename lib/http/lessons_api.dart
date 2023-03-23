import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/model/lessons/check_entity.dart';
import 'package:classes/model/lessons/check_stu_entity.dart';
import 'package:classes/model/lessons/lesson_entity.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/sp_utils.dart';

import '../model/error_entity.dart';
import 'dio_utils.dart';

class LessonAPI {

  static Future<Check?> createCheck(Json check) async {
    final data = check;
    data.removeWhere((key, value) => value == null);
    final result = await DioUtils.post('/lesson/check/create', params: data);
    if (result.statusCode == 200) {
      return Check.fromJson(result.data["d"]);
    }
    return null;
  }

  static Future<CheckStu?> createCheckStu(Json check) async {
    final data = check;
    final result = await DioUtils.post('/lesson/check/stu/create', params: data);
    if (result.statusCode == 200) {
      return CheckStu.fromJson(result.data["d"]);
    }
    return null;
  }

  static Future<Check?> getCheck(int infoId) async {
    final data = {
      "infoId": infoId,
      "userId": UserState.info?.userId
    };
    final result = await DioUtils.post('/lesson/check/query', params: data);
    if (result.statusCode == 200 && result.data['d'] != null) {
      return Check.fromJson(result.data["d"]);
    }
    return null;
  }

  static Future<int?> updateCheck(int checkId, String userId) async {
    final data = {
      "checkId": checkId,
      "userId": userId
    };
    final result = await DioUtils.post('/lesson/check/update', params: data);
    if (result.statusCode == 200 && result.data['d'] != null) {
      return result.data["d"];
    }
    return null;
  }

  static Future updateCheckStu(int id,int index) async {
    final data = {"id": id,"index":index};
    final result = await DioUtils.post('/lesson/check/stu/update', params: data);
    if (result.statusCode == 200 && result.data['d'] != null) {
      return result.data["d"];
    }
  }

  static Future getCheckList() async {
    final data = {"userId": UserState.info?.userId};
    final result = await DioUtils.post('/lesson/check/queryList', params: data);
    if (result.statusCode == 200 && result.data['d'] != null) {
      List<Check> data = result.data['d']
          .map<Check>((e) => Check.fromJson(e)).toList();
      return data;
    }
  }

  static Future getCheckStu(int checkId) async {
    final data = {"checkId": checkId};
    final result = await DioUtils.post('/lesson/check/stu/query', params: data);
    if (result.statusCode == 200 && result.data['d'] != null) {
      List<CheckStu> data = result.data['d']
          .map<CheckStu>((e) => CheckStu.fromJson(e)).toList();
      return data;
    }
  }

  static Future getCheckOne(int checkId) async {
    final data = {"userId": UserState.info?.userId};
    final result = await DioUtils.post('/lesson/check/stu/query', params: data);
    if (result.statusCode == 200 && result.data['d'] != null) {
      List<CheckStu> data = result.data['d']
          .map<CheckStu>((e) => CheckStu.fromJson(e)).toList();
      return data;
    }
  }

  static Future<Lesson?> createLesson(Json lesson) async {
    final data = lesson;
    data.removeWhere((key, value) => value == null);
    final result = await DioUtils.post('/lesson/create', params: data,showLoading: true);
    if (result.statusCode == 200 && result.data['d'] != null) {
      return Lesson.fromJson(result.data["d"]);
    }
    return null;
  }

  static Future getLesson(int infoId) async {
    final data = {
      "infoId": infoId,
      "userId": UserState.info?.userId
    };
    final result = await DioUtils.post('/lesson/query', params: data);
    if (result.statusCode == 200 && result.data['d'] != null) {
      return Lesson.fromJson(result.data["d"]);
    }
  }

  static Future getLessonList() async {
    final data = {"userId": UserState.info?.userId,"userType": UserState.info?.userType};
    final result = await DioUtils.post('/lesson/query', params: data);
    if (result.statusCode == 200 && result.data['d'] != null) {
      List<Lesson> data = result.data['d']
          .map<Lesson>((e) => Lesson.fromJson(e)).toList();
      return data;
    }
  }

  static Future createLessons(List<Json> list) async{
    final data = {"d":list};
    await DioUtils.post("/lesson/create/all", params: data, showLoading: true);
  }

  static Future getLessonSchedule(int infoId) async{
    final result = await DioUtils.post('/lesson/query/schedule', params: {"infoId": infoId});
    if (result.statusCode == 200 && result.data['d'] != null) {
      List<Schedule> data = result.data['d']
          .map<Schedule>((e) => Schedule.fromJson(e)).toList();
      return data;
    }
  }

  static Future deleteCheckStu(int id) async {
    final data = {"id": id};
    final result = await DioUtils.post('/lesson/check/stu/delete', params: data);
    if (result.statusCode == 200 && result.data['d'] != null) {
      return result.data["d"];
    }
  }
}