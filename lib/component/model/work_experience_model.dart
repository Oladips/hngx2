class WorkExperience {
  int? id;
  DateTime? startTime;
  DateTime? endTime;
  String? title;
  String? workplace;
  String? location;
  List<String>? activitiesDone;

  WorkExperience({
    this.id,
    this.startTime,
    this.endTime,
    this.title,
    this.workplace,
    this.location,
    this.activitiesDone,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      id: json["id"],
      startTime: DateTime.parse(json["startTime"]),
      endTime: DateTime.parse(json["endTime"]),
      title: json["title"],
      workplace: json["workplace"],
      location: json["location"],
      activitiesDone: json["activitiesDone"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "startTime": startTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "title": title,
        "workplace": workplace,
        "location": location,
        "activitiesDone": activitiesDone,
      };
}
