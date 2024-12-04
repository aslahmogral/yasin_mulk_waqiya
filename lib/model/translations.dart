class Translations {
  String? text;

  Translations({this.text});

  factory Translations.fromJson(Map<String, dynamic> json) => Translations(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}
