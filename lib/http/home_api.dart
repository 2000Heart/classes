
import 'package:classes/model/user_entity.dart';

import '../model/error_entity.dart';
import '../model/home/schedule_entity.dart';
import '../model/home/table_set.dart';
import '../states/user_state.dart';
import '../utils/sp_utils.dart';
import 'dio_utils.dart';

class HomeAPI{
  static Future<List<Schedule>?> getScheduleList() async {
    final data = {"userId": UserState.info?.userId};
    final result = await DioUtils.post("/schedule/query", params: data);
    if (result.statusCode == 200) {
      List<Schedule> data = result.data['d']
          .map<Schedule>((e) => Schedule.fromJson(e)).toList();
      return data;
    }
    return null;
  }

  static Future<List<Schedule>?> getUnitSchedule(int weekTime, int startUnit) async {
    final data = {
      "userId": UserState.info?.userId,
      "userType": UserState.info?.userType,
      "weekTime": weekTime,
      "startUnit": startUnit};
    final result = await DioUtils.post("/schedule/query/list", params: data);
    if (result.statusCode == 200) {
      List<Schedule> data = result.data['d']
          .map<Schedule>((e) => Schedule.fromJson(e)).toList();
      return data;
    }
    return null;
  }

  static Future getTableSet(int? userId) async {
    final data = {'userId': userId};
    final result = await DioUtils.post('/schedule/table/query', params: data);
    if (result.statusCode == 200) {
      return TableSet.fromJson(result.data["d"]);
    }else{
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }

  static Future updateTableSet(TableSet? table) async {
    final data = table?.toJson();
    final result = await DioUtils.post('/schedule/table/update', params: data);
    if (result.statusCode == 200) {
      return result.data["d"];
    }else{
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }
  
  // static Future createSchedule(Schedule schedule) async{
  //   final data = schedule.toJson();
  //   final result = await DioUtils.post('/schedule/create',params: data,showLoading: true);
  //   if(result.statusCode == 200){
  //     return result.data["d"];
  //   }
  // }

  static Future createSchedule(List<Json> list) async{
    final data = {"d":list};
    await DioUtils.post("/schedule/create/all", params: data, showLoading: true);
  }

  static Future updateSchedule(Schedule schedule) async{
    final data = schedule.toJson();
    final result = await DioUtils.post('/schedule/create',params: data,showLoading: true);
    if(result.statusCode == 200){
      return result.data["d"];
    }
  }
}