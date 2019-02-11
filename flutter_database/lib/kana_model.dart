import 'dart:convert';

Kana kanaFromJson(String str) {
  final jsonData = json.decode(str);
  return Kana.fromMap(jsonData);
}

String kanaToJson(Kana data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Kana {
  int id;
  String kana;
  String reading;

  Kana({
    this.id,
    this.kana,
    this.reading,
  });

  factory Kana.fromMap(Map<String, dynamic> json) => new Kana(
    id: json["id"],
    kana: json["kana"],
    reading: json["reading"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "kana": kana,
    "reading": reading,
  };
}