import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:inlima_mobile/models/asunto.dart';

class AsuntoService {
  Future<List<Asunto>> fetchAll() async {
    List<Asunto> asuntos = [];
    final String response =
        await rootBundle.loadString("assets/json/asuntos.json");
    final List<dynamic> data = jsonDecode(response);
    asuntos = data
        .map((map) => Asunto.fromMap(map as Map<String, dynamic>))
        .toList();
    return asuntos;
  }
}
