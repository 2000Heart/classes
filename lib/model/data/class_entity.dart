class ClassEntity {
  int? classId;
  String? className;
  String? teacherId;
  String? userId;
  String? schoolName;

  ClassEntity({this.classId, this.className, this.teacherId, this.userId, this.schoolName});

  ClassEntity.fromJson(Map<String, dynamic> json) {
    classId = json['classId'];
    className = json['className'];
    teacherId = json['teacherId'];
    userId = json['userId'];
    schoolName = json['schoolName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classId'] = this.classId;
    data['className'] = this.className;
    data['teacherId'] = this.teacherId;
    data['userId'] = this.userId;
    data['schoolName'] = this.schoolName;
    return data;
  }
}