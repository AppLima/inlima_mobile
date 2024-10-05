import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:inlima_mobile/models/ciudadano.dart';

class CiudadanoService {
  Future<List<Ciudadano>> fetchAll() async {
    List<Ciudadano> ciudadanos = [];
    // Cargar el archivo JSON desde los assets
    final String response =
        await rootBundle.loadString("assets/json/ciudadanos.json");
    
    // Decodificar el JSON en una lista de mapas
    final List<dynamic> data = jsonDecode(response);

    // Mapear cada elemento del JSON a un objeto de la clase Ciudadano
    ciudadanos = data
        .map((map) => Ciudadano.fromMap(map as Map<String, dynamic>))
        .toList();

    return ciudadanos;
  }
}