import 'package:classes/model/user_entity.dart';

class ClassEntity {
  String? teacherId;
  String? userId;
  String? className;
  String? schoolName;
  List<User>? students;

  ClassEntity(
      {this.teacherId,
        this.userId,
        this.className,
        this.schoolName,
        this.students});

  ClassEntity.fromJson(Map<String, dynamic> json) {
    teacherId = json['teacherId'];
    userId = json['userId'];
    className = json['className'];
    schoolName = json['schoolName'];
    if (json['students'] != null) {
      students = <User>[];
      json['students'].forEach((v) {
        students!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teacherId'] = this.teacherId;
    data['userId'] = this.userId;
    data['className'] = this.className;
    data['schoolName'] = this.schoolName;
    if (this.students != null) {
      data['students'] = this.students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}