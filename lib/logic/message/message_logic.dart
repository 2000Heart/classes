import 'package:classes/base/base_controller.dart';
import 'package:classes/http/message_api.dart';
import 'package:classes/model/message_entity.dart';

class MessageLogic extends BaseLogic{
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  void requestData() async{
    _messages = await MessageAPI.getMessages() ?? [];
    update();
  }
}