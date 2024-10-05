import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:inlima_mobile/models/usuario.dart';

class UsuarioService {
  Future<List<Usuario>> fetchAll() async {
    List<Usuario> usuarios = [];
    // Cargar el archivo JSON desde los assets
    final String response =
        await rootBundle.loadString("assets/json/usuarios.json");
    
    // Decodificar el JSON en una lista de mapas
    final List<dynamic> data = jsonDecode(response);

    // Mapear cada elemento del JSON a un objeto de la clase Usuario
    usuarios = data
        .map((map) => Usuario.fromMap(map as Map<String, dynamic>))
        .toList();

    return usuarios;
  }
}