class User {
  String? userId;
  String? userName;
  String? school;
  String? avatar;
  int? userType;
  int? classId;

  User(
      {this.userId,
        this.userName,
        this.school,
        this.avatar,
        this.userType,
        this.classId});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    school = json['school'];
    avatar = json['avatar'];
    userType = json['userType'];
    classId = json['classId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['school'] = this.school;
    data['avatar'] = this.avatar;
    data['userType'] = this.userType;
    data['classId'] = this.classId;
    return data;
  }
}