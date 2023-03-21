class CheckStu {
  int? id;
  int? checkId;
  int? userId;
  String? userName;
  int? index;

  CheckStu(
      {this.id, this.checkId, this.userId, this.userName, this.index});

  CheckStu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkId = json['checkId'];
    userId = json['userId'];
    userName = json['userName'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['checkId'] = this.checkId;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['index'] = this.index;
    return data;
  }
}