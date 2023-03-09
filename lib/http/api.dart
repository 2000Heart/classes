import 'package:classes/model/data/school_entity.dart';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/model/user_entity.dart';
import 'package:classes/states/user_state.dart';

import '../model/error_entity.dart';
import 'dio_utils.dart';

class Api{

  static Future login(String username,String password) async {
    final data = {
      'userName': username,
      'password': password,
    };
    final result = await DioUtils.post('/user/login', params: data);
    if (result.statusCode == 200) {
      return User.fromJson(result.data["d"]);
    }else{
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }

  static Future createUser(String username,String password,String school,String className) async {
    final data = {
      'userName': username,
      'password': password,
      'school': school,
      'className': className
    };
    final result = await DioUtils.post('/user/create', params: data);
    if (result.statusCode == 200) {
      return User.fromJson(result.data["d"]);
    }else{
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }

  static Future<List<School>> getSchoolList() async {
    final result = await DioUtils.post('/school/all');
    if (result.statusCode == 200) {
      List<School> data = result.data['d']
          .map<School>((e) => Schedule.fromJson(e)).toList();
      return data;
    }
    return [];
  }

  static Future<List<Schedule>?> getScheduleList() async {
    final data = {"userId": UserState.info?.userId};
    final result = await DioUtils.post("/resource/app-do/list", params: data);
    if (result.statusCode == 200 && result.data["c"] == 200) {
      List<Schedule> data = result.data['d']
          .map<Schedule>((e) => Schedule.fromJson(e)).toList();
      return data;
    }
    return null;
  }

  static Future getTableSet(int userId) async {
    final data = {'userId': userId};
    final result = await DioUtils.post('/schedule/', params: data);
    if (result.statusCode == 200) {
      return User.fromJson(result.data["d"]);
    }else{
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }
}