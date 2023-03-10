import 'package:classes/model/user_entity.dart';
import 'package:classes/utils/sp_utils.dart';

import '../model/home/table_set.dart';

class UserState{

  static User? get info => SpUtils.loginAuth;
  static TableSet? get tableSet => SpUtils.tableSet;

  static doLogout() async {
    SpUtils.loginAuth = null;
  }

}