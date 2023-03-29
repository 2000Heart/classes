import 'package:classes/http/api.dart';
import 'package:classes/model/user_entity.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/sp_utils.dart';
import 'package:classes/utils/toast_utils.dart';

import '../../base/base_controller.dart';

class MySettingLogic extends BaseLogic{
  bool _read = true;
  User _user = User.fromJson(UserState.info!.toJson());
  User _changed = User(userId: UserState.info?.userId);

  User get user => _user;
  bool get read => _read;

  set read(bool value) {
    _read = value;
    update();
  }
  set userName(String value) {
    _changed.userName = value;
    update();
  }
  set account(String value) {
    _changed.account = value;
    update();
  }
  set password(String value) {
    _changed.password = value;
    update();
  }
  set school(String value) {
    _changed.school = value;
    update();
  }
  set className(String value) {
    _changed.className = value;
    update();
  }

  Future updateData() async{
    User? res = await Api.updateUser(_changed);
    if(res != null) {
      SpUtils.loginAuth = res;
      _read = !_read;
    }
    _user = User.fromJson(UserState.info!.toJson());
    _changed = User(userId: UserState.info?.userId);
    update();
  }
}