import 'package:classes/model/data/classroom.dart';

import '../model/error_entity.dart';
import '../states/user_state.dart';
import '../utils/sp_utils.dart';
import 'dio_utils.dart';

class DataAPI{
  static Future createClassroom(Json room) async {
    var data = room;
    data.removeWhere((key, value) => value == null);
    final result = await DioUtils.post('/data/classroom/create', params: data,showLoading: true);
    if (result.statusCode == 200) {
      return Classroom.fromJson(result.data["d"]);
    } else {
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }

  static Future getClassroomList() async {
    final data = {"schoolName": UserState.info?.school};
    final result = await DioUtils.post('/data/classroom/list', params: data);
    if (result.statusCode == 200) {
      List<Classroom> data = result.data['d']
          .map<Classroom>((e) => Classroom.fromJson(e)).toList();
      return data;
    } else{
      return ErrorEntity.fromJson(result.data["d"]);
    }
  }
}