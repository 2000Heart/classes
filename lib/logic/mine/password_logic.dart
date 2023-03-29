import 'package:classes/base/base_controller.dart';
import 'package:classes/http/api.dart';
import 'package:classes/model/user_entity.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/toast_utils.dart';

class PasswordLogic extends BaseLogic{
 User user = User(userId: UserState.info?.userId,password: UserState.info?.password);
 String _oldPsw = "";
 String _newPsw = "";

 String get oldPsw => _oldPsw;
 String get newPsw => _newPsw;

 set oldPsw(String value) {
   _oldPsw = value;
   update();
 }
 set newPsw(String value) {
   _newPsw = value;
   update();
 }

 void updatePsw(){
   if(_newPsw.length <= 1){
     ToastUtils.show("密码不能为空");
   }else {
     if (_oldPsw == user.password) {
       user.password = _newPsw;
       Api.updateUser(user);
     } else {
       ToastUtils.show("原密码错误");
     }
   }
 }
}