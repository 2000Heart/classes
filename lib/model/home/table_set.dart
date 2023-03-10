class TableSet {
  int? tableId;
  int? userId;
  int? currentWeek;
  int? lessonNum;
  int? totalWeek;

  TableSet(
      {this.tableId,
        this.userId,
        this.currentWeek,
        this.lessonNum,
        this.totalWeek});

  TableSet.fromJson(Map<String, dynamic> json) {
    tableId = json['tableId'];
    userId = json['userId'];
    currentWeek = json['currentWeek'];
    lessonNum = json['lessonNum'];
    totalWeek = json['totalWeek'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tableId'] = this.tableId;
    data['userId'] = this.userId;
    data['currentWeek'] = this.currentWeek;
    data['lessonNum'] = this.lessonNum;
    data['totalWeek'] = this.totalWeek;
    return data;
  }
}