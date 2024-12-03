import 'dart:convert';

class Asunto {
  int id;
  String name;
  String logo;

  Asunto({
    required this.id,
    required this.name,
    required this.logo,
  });

  @override
  String toString() {
    return 'Asunto{id: $id, name: $name, logo: $logo}';
  }

  String toJSON(){
    final map = {
      'id': id,
      'name': name,
      'logo': logo,
    };
    return jsonEncode(map);
  }

  factory Asunto.fromMap(Map<String, dynamic> map) {
    return Asunto(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      logo: map['logo'] ?? '',
    );
  }
}