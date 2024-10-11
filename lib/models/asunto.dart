import 'dart:convert';

class Asunto {
  int id;
  String name;
  String urlSvg;

  Asunto({
    required this.id,
    required this.name,
    required this.urlSvg,
  });

  @override
  String toString() {
    return 'Asunto{id: $id, name: $name, urlSvg: $urlSvg}';
  }

  String toJSON(){
    final map = {
      'id': id,
      'name': name,
      'url_svg': urlSvg,
    };
    return jsonEncode(map);
  }

  factory Asunto.fromMap(Map<String, dynamic> map) {
    return Asunto(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      urlSvg: map['url_svg'] ?? '',
    );
  }
}