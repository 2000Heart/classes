import 'package:classes/model/data/class_entity.dart';
import 'package:classes/model/data/classroom.dart';
import 'package:classes/model/data/lesson_entity.dart';

import '../model/error_entity.dart';
import '../states/user_state.dart';
import '../utils/sp_utils.dart';
import 'dio_utils.dart';

class DataAPI{
  static Future createClassroom(Json room) async {
    var data = room;
    data.removeWhere((key, value) => value == null);
    final result = await DioUtils.post('/data/classroom/create', params: data,showLoading: true);
    if (result.statusCode == 200) {
      return Classroom.fromJson(result.data["d"]);
    } else {
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }

  static Future getLesson(String lesson) async {
    var data = {"lessonName": lesson};
    final result = await DioUtils.post('/data/lesson/get', params: data,showLoading: true);
    if (result.statusCode == 200) {
      return LessonEntity.fromJson(result.data["d"]);
    } else {
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }

  static Future getClassroomList() async {
    final data = {"schoolName": UserState.info?.school};
    final result = await DioUtils.post('/data/classroom/list', params: data);
    if (result.statusCode == 200) {
      List<Classroom> data = result.data['d']
          .map<Classroom>((e) => Classroom.fromJson(e)).toList();
      return data;
    } else{
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }

  static Future getClassList() async {
    final data = {"schoolName": UserState.info?.school,"teacherId": UserState.info?.userId};
    final result = await DioUtils.post('/data/class/query/list', params: data);
    if (result.statusCode == 200) {
      List<ClassEntity> data = result.data['d']
          .map<ClassEntity>((e) => ClassEntity.fromJson(e)).toList();
      return data;
    } else{
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }

  static Future<Classroom?> getClassroom(String roomName) async {
    var data = {"roomName": roomName,"schoolName":UserState.info?.school};
    final result = await DioUtils.post('/data/classroom/query', params: data,showLoading: true);
    if (result.statusCode == 200) {
      return Classroom.fromJson(result.data["d"]);
    }
    return null;
  }
}