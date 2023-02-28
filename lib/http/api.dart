import 'package:classes/model/user_entity.dart';

import '../model/error_entity.dart';
import 'dio_utils.dart';

class Api{
  static Future login(String username,String password,String school) async {
    final data = {
      'userName': username,
      'password': password,
      'school': "string"
    };
    final result = await DioUtils.post('/app/login', params: data);
    if (result.statusCode == 200) {
      return User.fromJson(result.data["d"]);
    }else{
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }
}