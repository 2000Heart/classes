import 'dart:convert';
import 'dart:developer';

import 'package:classes/http/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/home/table_set.dart';
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
  static TableSet? _tableSet;

  static TableSet? get tableSet {
    if (_tableSet != null) {
      return _tableSet;
    }
    final str = sp.getString(_tableKey);
    try {
      final json = jsonDecode(str ?? "");
      final table = TableSet.fromJson(json);
      _tableSet = table;
      return table;
    } catch (err) {
      log("sp utils get table err $err");
      return null;
    }
  }

  static set tableSet(TableSet? value) {
    try {
      Api.updateTableSet(value);
      _tableSet = value;
      final json = value?.toJson();
      final str = jsonEncode(json);
      sp.setString(_tableKey, str);
      log("sp set table $str");
    } catch (err) {
      if (value == null) {
        sp.remove(_tableKey);
      }
      log("sp set table err $err");
    }
  }

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
      log("sp utils get login err $err");
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
      log("set login auth err $err");
    }
  }
}
