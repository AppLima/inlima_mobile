import 'dart:convert';

class Queja {
  int id;
  String name;
  String urlSvg;

  Queja({
    required this.id,
    required this.name,
    required this.urlSvg,
  });

  @override
  String toString() {
    return 'Queja{id: $id, name: $name, urlSvg: $urlSvg}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url_svg': urlSvg,
    };
  }

  factory Queja.fromMap(Map<String, dynamic> map) {
    return Queja(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      urlSvg: map['url_svg'] ?? '',
    );
  }
}