import 'package:classes/states/user_state.dart';

class Message {
  int? messageId;
  int? posterId;
  String? posterName;
  String? userAll;
  String? title;
  String? content;
  String? postTime;
  int? type;

  Message(
      {this.messageId,
        this.posterId,
        this.posterName,
        this.userAll,
        this.title,
        this.content,
        this.postTime,
        this.type});

  Message.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    posterId = json['posterId'];
    posterName = json['posterName'];
    userAll = json['userAll'];
    title = json['title'];
    content = json['content'];
    postTime = json['postTime'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageId'] = this.messageId;
    data['posterId'] = this.posterId;
    data['posterName'] = this.posterName;
    data['userAll'] = this.userAll;
    data['title'] = this.title;
    data['content'] = this.content;
    data['postTime'] = this.postTime;
    data['type'] = this.type;
    return data;
  }
}

extension MessageEx on Message{
  String? toContent() {
    var userType = UserState.info?.userType;
    switch(type){
      case 0:
        return userType == 0?
         '教师$posterName$content':"您$content";
      case 1:
        return userType == 0?
        '教师$posterName$content':'您$content';
      default:
        return content;
    }
  }}