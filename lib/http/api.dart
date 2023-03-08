import 'package:classes/model/data/school_entity.dart';
import 'package:classes/model/user_entity.dart';

import '../model/error_entity.dart';
import 'dio_utils.dart';

class Api{

  static Future login(String username,String password) async {
    final data = {
      'userName': username,
      'password': password,
    };
    final result = await DioUtils.post('/app/login', params: data);
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
    final result = await DioUtils.post('user/create', params: data);
    if (result.statusCode == 200) {
      return User.fromJson(result.data["d"]);
    }else{
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }

  // static Future<List<School>> getSchoolList() async {
  //   final result = await DioUtils.post('/school/all');
  //   if (result.statusCode == 200) {
  //     return List.fromJson(result.data["d"]);
  //   }else{
  //     return ErrorEntity.fromJson(result.data["d"]);
  //   }
  // }
}