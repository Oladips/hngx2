class Language {
  int? id;
  String? language;
  String? fluency;

  Language({
    this.id,
    this.language,
    this.fluency,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json["id"],
      language: json["language"],
      fluency: json["fluency"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "language": language,
        "fluency": fluency,
      };
}
