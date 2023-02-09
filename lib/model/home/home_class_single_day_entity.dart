class HomeClassSingeDayEntity {
  int? classId;
  String? className;
  int? start;
  int? end;
  String? teacher;
  String? classroom;

  HomeClassSingeDayEntity(
      {this.classId,
        this.className,
        this.start,
        this.end,
        this.teacher,
        this.classroom});

  HomeClassSingeDayEntity.fromJson(Map<String, dynamic> json) {
    classId = json['classId'];
    className = json['className'];
    start = json['start'];
    end = json['end'];
    teacher = json['teacher'];
    classroom = json['classroom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classId'] = this.classId;
    data['className'] = this.className;
    data['start'] = this.start;
    data['end'] = this.end;
    data['teacher'] = this.teacher;
    data['classroom'] = this.classroom;
    return data;
  }
}