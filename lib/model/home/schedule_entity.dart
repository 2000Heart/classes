class Schedule {
  int? lessonId;
  String? lessonName;
  int? teacherId;
  String? teacherName;
  String? userId;
  String? duration;
  int? weekTime;
  int? startUnit;
  int? endUnit;
  String? classroom;
  int? eventId;

  Schedule(
      {this.lessonId,
        this.lessonName,
        this.teacherId,
        this.teacherName,
        this.userId,
        this.duration,
        this.weekTime,
        this.startUnit,
        this.endUnit,
        this.classroom,
        this.eventId});

  Schedule.fromJson(Map<String, dynamic> json) {
    lessonId = json['lessonId'];
    lessonName = json['lessonName'];
    teacherId = json['teacherId'];
    teacherName = json['teacherName'];
    userId = json['userId'];
    duration = json['duration'];
    weekTime = json['weekTime'];
    startUnit = json['startUnit'];
    endUnit = json['endUnit'];
    classroom = json['classroom'];
    eventId = json['eventId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lessonId'] = this.lessonId;
    data['lessonName'] = this.lessonName;
    data['teacherId'] = this.teacherId;
    data['teacherName'] = this.teacherName;
    data['userId'] = this.userId;
    data['duration'] = this.duration;
    data['weekTime'] = this.weekTime;
    data['startUnit'] = this.startUnit;
    data['endUnit'] = this.endUnit;
    data['classroom'] = this.classroom;
    data['eventId'] = this.eventId;
    return data;
  }
}