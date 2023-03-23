import 'package:classes/states/user_state.dart';

class Message with Content{
  int? messageId;
  int? posterId;
  String? posterName;
  String? userAll;
  String? title;
  String? postTime;
  int? type;

  Message(
      {this.messageId,
        this.posterId,
        this.posterName,
        this.userAll,
        this.title,
        this.postTime,
        this.type});

  Message.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    posterId = json['posterId'];
    posterName = json['posterName'];
    userAll = json['userAll'];
    title = json['title'];
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
    data['postTime'] = this.postTime;
    data['type'] = this.type;
    return data;
  }
}

mixin Content{
  String content = "";
}

extension MessageEx on Message{
  String get toContent {
    var userType = UserState.info?.userType;
    switch(type){
      case 0:
        return userType == 0?
         '教师$posterName创建了此课程，您已被加入。':'您成功创建了此课程';
      case 1:
        return userType == 0?
        '教师$posterName发布了本课程的签到，请记得届时上课签到。':'您成功发布本课程签到';
      case 10:
        return '签到即将开始，请注意到课签到';
      case 11:
        return '签到即将结束，请注意签到情况';
      // case 12:
      //   return '签到结束，'
      default:
        return "";

    }
  }}