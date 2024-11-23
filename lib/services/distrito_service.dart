import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:inlima_mobile/configs/constants.dart';
import 'package:inlima_mobile/models/distrito.dart';
import '../models/service_http_response.dart';
import 'package:http/http.dart' as http;

class DistritoService {
  // Método para obtener todos los distritos desde un archivo JSON
  final String baseUrl = '${BASE_URL}';
  Future<List<Distrito>> fetchAll() async {
    final url = Uri.parse('${baseUrl}district');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['success'] == true) {
          // Mapear los datos a una lista de objetos Distrito
          return (body['data'] as List)
              .map((map) =>
                  Distrito.fromMap(map)) // Cambiar de `fromJson` a `fromMap`
              .toList();
        } else {
          throw Exception(body['message']);
        }
      } else {
        throw Exception("Error al cargar distritos: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error al cargar distritos: $e");
    }
  }


  // Método para buscar el ID del distrito por el nombre
  Future<Distrito?> getDistritoByName(String nombre) async {
    List<Distrito> distritos = await fetchAll();

    try {
      // Buscar el distrito por el nombre
      return distritos.firstWhere((distrito) => distrito.name == nombre);
    } catch (e) {
      print("Distrito con el nombre $nombre no encontrado");
      return null; // Si no se encuentra el distrito, retornamos null
    }
  }

  // Método para buscar el nombre del distrito por el ID
  Future<Distrito?> getDistritoById(int id) async {
    List<Distrito> distritos = await fetchAll();

    try {
      // Buscar el distrito por el ID
      return distritos.firstWhere((distrito) => distrito.id == id);
    } catch (e) {
      print("Distrito con el ID $id no encontrado");
      return null; // Si no se encuentra el distrito, retornamos null
    }
  }
}
