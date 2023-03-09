class Check {
  int? lessonId;
  int? teacherId;
  String? postTime;
  String? checkedUser;
  String? userAll;
  String? startTime;
  String? endTime;
  int? status;
  int? checkId;

  Check(
      {this.lessonId,
        this.teacherId,
        this.postTime,
        this.checkedUser,
        this.userAll,
        this.startTime,
        this.endTime,
        this.status,
        this.checkId});

  Check.fromJson(Map<String, dynamic> json) {
    lessonId = json['lessonId'];
    teacherId = json['teacherId'];
    postTime = json['postTime'];
    checkedUser = json['checkedUser'];
    userAll = json['userAll'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
    checkId = json['checkId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lessonId'] = this.lessonId;
    data['teacherId'] = this.teacherId;
    data['postTime'] = this.postTime;
    data['checkedUser'] = this.checkedUser;
    data['userAll'] = this.userAll;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['status'] = this.status;
    data['checkId'] = this.checkId;
    return data;
  }
}