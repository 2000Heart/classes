import '../t_mix.dart';

class Lesson with TMix{
  int? lessonId;
  String? lessonName;
  String? teacherId;
  String? teacherName;
  String? lessonTask;
  int? checkId;
  String? eventId;
  String? userId;
  int? infoId;
  String? schoolName;
  String? duration;

  Lesson(
      {this.lessonId,
        this.lessonName,
        this.teacherId,
        this.teacherName,
        this.lessonTask,
        this.checkId,
        this.eventId,
        this.userId,
        this.infoId,
        this.schoolName,
        this.duration});

  Lesson.fromJson(Map<String, dynamic> json) {
    lessonId = json['lessonId'];
    lessonName = json['lessonName'];
    teacherId = json['teacherId'];
    teacherName = json['teacherName'];
    lessonTask = json['lessonTask'];
    checkId = json['checkId'];
    eventId = json['eventId'];
    userId = json['userId'];
    infoId = json['infoId'];
    schoolName = json['schoolName'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lessonId'] = this.lessonId;
    data['lessonName'] = this.lessonName;
    data['teacherId'] = this.teacherId;
    data['teacherName'] = this.teacherName;
    data['lessonTask'] = this.lessonTask;
    data['checkId'] = this.checkId;
    data['eventId'] = this.eventId;
    data['userId'] = this.userId;
    data['infoId'] = this.infoId;
    data['schoolName'] = this.schoolName;
    data['duration'] = this.duration;
    return data;
  }
}