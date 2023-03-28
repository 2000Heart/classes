import 'package:classes/http/api.dart';
import 'package:classes/model/user_entity.dart';
import 'package:classes/states/user_state.dart';

import '../../base/base_controller.dart';

class MySettingLogic extends BaseLogic{
  bool _read = true;
  User _user = User.fromJson(UserState.info!.toJson());

  User get user => _user;
  bool get read => _read;

  set read(bool value) {
    _read = value;
    update();
  }
  set raw(User value) {
    _user = value;
    update();
  }
  set userName(String value) {
    _user.userName = value;
    update();
  }
  set account(String value) {
    _user.account = value;
    update();
  }
  set password(String value) {
    _user.password = value;
    update();
  }
  set school(String value) {
    _user.school = value;
    update();
  }
  set className(String value) {
    _user.className = value;
    update();
  }

  Future updateData() async{
    await Api.updateUser(_user);
  }
}