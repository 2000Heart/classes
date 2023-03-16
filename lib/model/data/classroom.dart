class Classroom {
  int? roomId;
  int? schoolName;
  String? roomName;
  String? column;
  String? row;

  Classroom(
      {this.roomId, this.schoolName, this.roomName, this.column, this.row});

  Classroom.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    schoolName = json['schoolName'];
    roomName = json['roomName'];
    column = json['column'];
    row = json['row'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomId'] = this.roomId;
    data['schoolName'] = this.schoolName;
    data['roomName'] = this.roomName;
    data['column'] = this.column;
    data['row'] = this.row;
    return data;
  }
}