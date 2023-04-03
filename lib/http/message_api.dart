import 'package:classes/model/message_entity.dart';
import 'package:classes/model/user_entity.dart';
import 'package:classes/states/user_state.dart';

import '../utils/sp_utils.dart';
import 'dio_utils.dart';

class MessageAPI{
  static Future<Message?> createMessage(
      {required String title, required String userAll, required String content, required int type}) async {
    final data = Message(
      posterId: UserState.info?.userId,
      posterName: UserState.info?.userName,
      title: title,
      content: content,
      postTime: DateTime.now().toIso8601String(),
      userAll: userAll,
      type: type
    ).toJson();
    data.removeWhere((key, value) => value==null);
    final result = await DioUtils.post('/message/create', params: data,showLoading: true);
    if (result.statusCode == 200 && result.data['d'] != null) {
      Message data = Message.fromJson(result.data["d"]);
      return data;
    }
    return null;
  }

  static Future<List<Message>?> getMessages() async {
    final data = {"userId": UserState.info?.userId};
    final result = await DioUtils.post('/message/query', params: data);
    if (result.statusCode == 200 && result.data['d'] != null) {
      List<Message> data = result.data['d']
          .map<Message>((e) => Message.fromJson(e)).toList();
      return data;
    }
    return null;
  }
}