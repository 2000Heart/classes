import 'package:classes/model/t_mix.dart';

class User with TMix{
  int? userId;
  String? userName;
  String? password;
  String? school;
  String? avatar;
  int? userType;
  String? academy;
  String? major;
  int? classId;
  String? className;
  String? account;

  User(
      {this.userId,
        this.userName,
        this.password,
        this.school,
        this.avatar,
        this.userType,
        this.academy,
        this.major,
        this.classId,
        this.className,
        this.account});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    password = json['password'];
    school = json['school'];
    avatar = json['avatar'];
    userType = json['userType'];
    academy = json['academy'];
    major = json['major'];
    classId = json['classId'];
    className = json['className'];
    account = json['account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['school'] = this.school;
    data['avatar'] = this.avatar;
    data['userType'] = this.userType;
    data['academy'] = this.academy;
    data['major'] = this.major;
    data['classId'] = this.classId;
    data['className'] = this.className;
    data['account'] = this.account;
    return data;
  }
}