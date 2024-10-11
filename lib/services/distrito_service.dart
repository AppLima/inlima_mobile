import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:inlima_mobile/models/distrito.dart';

class DistritoService {
  // Método para obtener todos los distritos desde un archivo JSON
  Future<List<Distrito>> fetchAll() async {
    try {
      final String response = await rootBundle.loadString("assets/json/distritos.json");
      final List<dynamic> data = jsonDecode(response);

      return data.map((map) => Distrito.fromMap(map as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Error cargando distritos: $e");
      return [];
    }
  }

  // Método para buscar el ID del distrito por el nombre
  Future<Distrito?> getDistritoByName(String nombre) async {
    List<Distrito> distritos = await fetchAll();

    try {
      // Buscar el distrito por el nombre
      return distritos.firstWhere((distrito) => distrito.nombre == nombre);
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
