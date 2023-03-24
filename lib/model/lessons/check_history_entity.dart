class CheckHistory {
  int? infoId;
  String? lessonName;
  int? teacherId;
  String? teacherName;
  String? postTime;
  String? userAll;
  String? startTime;
  String? endTime;
  String? column;
  String? row;
  int? checkId;
  int? checked;
  int? need;
  String? miss;

  CheckHistory(
      {this.infoId,
        this.lessonName,
        this.teacherId,
        this.teacherName,
        this.postTime,
        this.userAll,
        this.startTime,
        this.endTime,
        this.column,
        this.row,
        this.checkId,
        this.checked,
        this.need,
        this.miss});

  CheckHistory.fromJson(Map<String, dynamic> json) {
    infoId = json['infoId'];
    lessonName = json['lessonName'];
    teacherId = json['teacherId'];
    teacherName = json['teacherName'];
    postTime = json['postTime'];
    userAll = json['userAll'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    column = json['column'];
    row = json['row'];
    checkId = json['checkId'];
    checked = json['checked'];
    need = json['need'];
    miss = json['miss'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['infoId'] = this.infoId;
    data['lessonName'] = this.lessonName;
    data['teacherId'] = this.teacherId;
    data['teacherName'] = this.teacherName;
    data['postTime'] = this.postTime;
    data['userAll'] = this.userAll;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['column'] = this.column;
    data['row'] = this.row;
    data['checkId'] = this.checkId;
    data['checked'] = this.checked;
    data['need'] = this.need;
    data['miss'] = this.miss;
    return data;
  }
}