import '../t_mix.dart';

class Check with TMix{
  int? infoId;
  int? lessonId;
  String? lessonName;
  int? teacherId;
  String? teacherName;
  String? postTime;
  String? checkedUser;
  String? userAll;
  String? startTime;
  String? endTime;
  String? column;
  String? row;
  int? status;
  int? checkId;

  Check(
      {this.infoId,
        this.lessonId,
        this.lessonName,
        this.teacherId,
        this.teacherName,
        this.postTime,
        this.checkedUser,
        this.userAll,
        this.startTime,
        this.endTime,
        this.column,
        this.row,
        this.status,
        this.checkId});

  Check.fromJson(Map<String, dynamic> json) {
    infoId = json['infoId'];
    lessonId = json['lessonId'];
    lessonName = json['lessonName'];
    teacherId = json['teacherId'];
    teacherName = json['teacherName'];
    postTime = json['postTime'];
    checkedUser = json['checkedUser'];
    userAll = json['userAll'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    column = json['column'];
    row = json['row'];
    status = json['status'];
    checkId = json['checkId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['infoId'] = this.infoId;
    data['lessonId'] = this.lessonId;
    data['lessonName'] = this.lessonName;
    data['teacherId'] = this.teacherId;
    data['teacherName'] = this.teacherName;
    data['postTime'] = this.postTime;
    data['checkedUser'] = this.checkedUser;
    data['userAll'] = this.userAll;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['column'] = this.column;
    data['row'] = this.row;
    data['status'] = this.status;
    data['checkId'] = this.checkId;
    return data;
  }
}