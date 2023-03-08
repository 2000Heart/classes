class School {
  int? schoolId;
  String? schoolName;

  School({this.schoolId, this.schoolName});

  School.fromJson(Map<String, dynamic> json) {
    schoolId = json['schoolId'];
    schoolName = json['schoolName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schoolId'] = this.schoolId;
    data['schoolName'] = this.schoolName;
    return data;
  }
}