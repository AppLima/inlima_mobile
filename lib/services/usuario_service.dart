import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:inlima_mobile/models/usuario.dart';

class UsuarioService {
  final String _file = 'assets/json/usuarios.json';

  Future<List<Usuario>> fetchAll() async {
    List<Usuario> usuarios = [];
    final String response = await rootBundle.loadString(_file);
    final List<dynamic> data = jsonDecode(response);
    usuarios = data.map((map) => Usuario.fromMap(map as Map <String, dynamic>)).toList();
    return usuarios;
  }

  Future<bool> isEmailAlreadyRegistered(String email) async {
    List<Usuario> usuarios = await fetchAll();
    return usuarios.any((usuario) => usuario.email == email);
  }

  Future<Usuario> findByEmail(String email) async {
    List<Usuario> usuarios = await fetchAll();
    return usuarios.firstWhere((usuario) => usuario.email == email);
  }

    Future<int> getNewId() async {
    List<Usuario> usuarios = await fetchAll();
    return usuarios.isNotEmpty ? usuarios.last.idUsuario + 1 : 1;
  }
}