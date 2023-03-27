import 'package:classes/base/base_controller.dart';

class MineLogic extends BaseLogic{
  bool _pic = false;

  bool get pic => _pic;

  set pic(bool value) {
    _pic = value;
    update();
  }
}