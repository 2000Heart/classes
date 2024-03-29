import 'package:classes/model/data/school_entity.dart';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:classes/model/home/table_set.dart';
import 'package:classes/model/user_entity.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/sp_utils.dart';
import 'package:dio/dio.dart';

import '../model/error_entity.dart';
import 'dio_utils.dart';

class Api{

  static Future<User?> login(String account,String password) async {
    final data = {
      'account': account,
      'password': password,
    };
    final result = await DioUtils.post('/user/login', params: data);
    if (result.statusCode == 200) {
      final data = User.fromJson(result.data["d"]);
      data.t = result.data["t"];
      return data;
    }
    return null;
  }

  static Future<User?> createUser(User user) async {
    final data = user.toJson();
    data.removeWhere((key, value) => value == null);
    final result = await DioUtils.post('/user/create', params: data);
    if (result.statusCode == 200) {
      final data = User.fromJson(result.data["d"] ?? {});
      data.t = result.data["t"];
      return data;
    }
    return null;
  }

  static Future<List<School>> getSchoolList() async {
    final result = await DioUtils.post('/school/all');
    if (result.statusCode == 200) {
      List<School> data = result.data['d']
          .map<School>((e) => School.fromJson(e)).toList();
      return data;
    }
    return [];
  }

  static Future<User?> updateUser(User user) async{
    final data = user.toJson();
    data.removeWhere((key, value) => value == null);
    final result = await DioUtils.post('/user/update', params: data);
    if (result.statusCode == 200 && result.data['d'] != null) {
      final data = User.fromJson(result.data["d"]);
      data.t = result.data["t"];
      return data;
    }
    return null;
  }

  static Future<User?> uploadImage(String path) async{
    final file = await MultipartFile.fromFile(path);
    final data = FormData.fromMap({
      'userId': UserState.info?.userId,
      'file': file
    });
    final result = await DioUtils.post('/data/avatar/upload', params: data);
    if (result.statusCode == 200) {
      final data = User.fromJson(result.data["d"]);
      data.t = result.data["t"];
      return data;
    }
    return null;
  }
}