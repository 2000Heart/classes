import 'package:classes/model/data/class_entity.dart';
import 'package:classes/model/data/classroom.dart';
import 'package:classes/model/data/lesson_entity.dart';

import '../model/data/school_entity.dart';
import '../model/error_entity.dart';
import '../states/user_state.dart';
import '../utils/sp_utils.dart';
import 'dio_utils.dart';

class DataAPI{
  static Future<Classroom?> createClassroom(Json room) async {
    var data = room;
    data.removeWhere((key, value) => value == null);
    final result = await DioUtils.post('/data/classroom/create', params: data,showLoading: true);
    if (result.statusCode == 200) {
      final data = Classroom.fromJson(result.data["d"]);
      data.t = result.data["t"];
      return data;
    }
    return null;
  }

  static Future<LessonEntity?> getLesson(String lesson) async {
    var data = {"lessonName": lesson};
    final result = await DioUtils.post('/data/lesson/get', params: data,showLoading: true);
    if (result.statusCode == 200) {
      final data = LessonEntity.fromJson(result.data["d"]);
      data.t = result.data["t"];
      return data;
    }
    return null;
  }

  static Future<List<Classroom>?> getClassroomList() async {
    final data = {"schoolName": UserState.info?.school};
    final result = await DioUtils.post('/data/classroom/list', params: data);
    if (result.statusCode == 200) {
      List<Classroom> data = result.data['d']
          .map<Classroom>((e) => Classroom.fromJson(e)).toList();
      return data;
    }
    return null;
  }

  static Future<List<ClassEntity>?> getClassList() async {
    final data = {"schoolName": UserState.info?.school,"teacherId": UserState.info?.userId};
    final result = await DioUtils.post('/data/class/query/list', params: data);
    if (result.statusCode == 200) {
      List<ClassEntity> data = result.data['d']
          .map<ClassEntity>((e) => ClassEntity.fromJson(e)).toList();
      return data;
    }
    return null;
  }

  static Future<List<ClassEntity>?> getSchoolClassList(String school) async {
    final data = {"schoolName": school};
    final result = await DioUtils.post('/data/class/query/school/list', params: data);
    if (result.statusCode == 200) {
      List<ClassEntity> data = result.data['d']
          .map<ClassEntity>((e) => ClassEntity.fromJson(e)).toList();
      return data;
    }
    return null;
  }

  static Future<Classroom?> getClassroom(String roomName) async {
    var data = {"roomName": roomName,"schoolName":UserState.info?.school};
    final result = await DioUtils.post('/data/classroom/query', params: data,showLoading: true);
    if (result.statusCode == 200) {
      return Classroom.fromJson(result.data["d"]);
    }
    return null;
  }

  static Future<List<School>?> getSchool() async{
    final result = await DioUtils.post('/data/school/all',showLog: false);
    if (result.statusCode == 200) {
      List<School> data = result.data['d']
          .map<School>((e) => School.fromJson(e)).toList();
      return data;
    }
    return null;
  }

}