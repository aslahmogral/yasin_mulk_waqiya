class Ayah {
  final int number;
  // final int juzNumber;
  final String text_uthmani;
  final String verseKey;

  Ayah({required this.number, required this.text_uthmani, required this.verseKey});

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(number: json['id'], text_uthmani: json['text_uthmani'], verseKey: json['verse_key'],);
  }
}
