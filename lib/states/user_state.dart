import 'package:classes/model/user_entity.dart';
import 'package:classes/utils/sp_utils.dart';

class UserState{

  static User? get info => SpUtils.loginAuth;

  static doLogout() async {
    SpUtils.loginAuth = null;
  }

}