class EducationModel {
  int? id;
  DateTime? startTime;
  DateTime? endTime;
  String? school;
  String? qualification;

  EducationModel({
    this.id,
    this.startTime,
    this.endTime,
    this.school,
    this.qualification,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json["id"],
      startTime: DateTime.parse(json["startTime"]),
      endTime: DateTime.parse(json["endTime"]),
      school: json["school"],
      qualification: json["qualification"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "startTime": startTime,
        "endTime": endTime,
        "school": school,
        "qualification": qualification,
      };
}
