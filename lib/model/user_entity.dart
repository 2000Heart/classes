class User {
  String? password;
  String? avatar;
  int? userType;
  String? userName;
  String? school;
  int? userId;

  User(
      {this.password,
        this.avatar,
        this.userType,
        this.userName,
        this.school,
        this.userId});

  User.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    avatar = json['avatar'];
    userType = json['userType'];
    userName = json['userName'];
    school = json['school'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['avatar'] = this.avatar;
    data['userType'] = this.userType;
    data['userName'] = this.userName;
    data['school'] = this.school;
    data['userId'] = this.userId;
    return data;
  }
}