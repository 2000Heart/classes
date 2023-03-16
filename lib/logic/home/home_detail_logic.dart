import 'package:classes/base/base_controller.dart';
import 'package:classes/http/home_api.dart';
import 'package:classes/model/home/schedule_entity.dart';
import 'package:get/get.dart';

class HomeDetailLogic extends BaseLogic{
  late List<bool> _read;
  List<Schedule>? _data;
  Schedule _raw = Schedule();

  Schedule get raw => _raw;
  List<Schedule> get data => _data ?? [];
  List<bool> get read => _read;

  set read(List<bool> value) {
    _read = value;
    update();
  }
  set raw(Schedule value) {
    _raw = value;
    update();
  }
  set lessonName(String value) {
    _raw.lessonName = value;
    update();
  }
  set duration(String value) {
    _raw.duration = value;
    update();
  }
  set time(List<int> value) {
    _raw.weekTime = value[0];
    _raw.startUnit = value[1];
    _raw.endUnit = value[2];
    update();
  }
  set classroom(String value) {
    _raw.classroom = value;
    update();
  }
  set teacherName(String value) {
    _raw.classroom = value;
    update();
  }
  void setData(int index){
    _data?[index] = _raw;
    update();
  }

  Future requestData() async {
    _data = await HomeAPI.getUnitSchedule(Get.arguments[0], Get.arguments[1]);
    _read = List.generate(_data?.length ?? 0, (index) => true);
    update();
  }

  Future updateData() async{
    await HomeAPI.updateSchedule(_raw);
  }
}