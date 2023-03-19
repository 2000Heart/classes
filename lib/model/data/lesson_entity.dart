class LessonEntity{
  int? lessonId;
  String? lessonName;

  LessonEntity(
      {this.lessonId,
        this.lessonName,});

  LessonEntity.fromJson(Map<String, dynamic> json) {
    lessonId = json['lessonId'];
    lessonName = json['lessonName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lessonId'] = this.lessonId;
    data['lessonName'] = this.lessonName;
    return data;
  }
}