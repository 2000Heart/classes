import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_entity.dart';

typedef Json = Map<String, dynamic>;

class SpUtils {
  static late SharedPreferences sp;
  static const _loginAuthKey = "loginAuth";
  static const _tableKey = "table";
  
  static initSp() async {
    sp = await SharedPreferences.getInstance();
  }

  static bool setJson(String key, Map<String, dynamic>? json) {
    try {
      if (json == null) {
        sp.remove(key);
      } else {
        final str = jsonEncode(json);
        sp.setString(key, str);
      }
      return true;
    } catch (err) {
      log("set json data err $err");
      return false;
    }
  }

  static Map<String, dynamic>? getJson(String key) {
    try {
      final str = sp.getString(key)!;
      return jsonDecode(str);
    } catch (err) {
      log("get json err $err");
    }
    return null;
  }



  static User? _loginAuth;

  static User? get loginAuth {
    if (_loginAuth != null) {
      return _loginAuth;
    }
    final str = sp.getString(_loginAuthKey);
    try {
      final json = jsonDecode(str ?? "");
      final auth = User.fromJson(json);
      _loginAuth = auth;
      return auth;
    } catch (err) {
      log("sp utils get login err ${err}");
      return null;
    }
  }

  static set loginAuth(User? en) {
    try {
      _loginAuth = en;
      final json = en?.toJson();
      final str = jsonEncode(json);
      sp.setString(_loginAuthKey, str);
      log("set login auth $str");
    } catch (err) {
      if (en == null) {
        sp.remove(_loginAuthKey);
      }
      log("set login auth err ${err}");
    }
  }
}
