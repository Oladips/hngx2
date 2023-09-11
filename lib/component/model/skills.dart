class Skill {
  int? id;
  String? skill;

  Skill({
    this.id,
    this.skill,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json["id"],
      skill: json["skill"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "Skill": Skill,
      };
}
