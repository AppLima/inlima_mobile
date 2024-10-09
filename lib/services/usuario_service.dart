import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:inlima_mobile/models/usuario.dart';

class UsuarioService {
  final String _fileName = 'usuarios_local.json'; // Archivo local donde se guardarán las modificaciones
  bool _initialized = false;

  // Método para inicializar el archivo local si no existe
  Future<void> _initializeFile() async {
    final file = await _getFile();
    if (!await file.exists()) {
      // Si el archivo no existe, copiar el contenido de assets/usuarios.json
      final String content = await rootBundle.loadString('assets/json/usuarios.json');
      await file.writeAsString(content);
    }
    _initialized = true;
  }

  // Obtiene todos los usuarios desde el archivo
  Future<List<Usuario>> fetchAll() async {
    if (!_initialized) await _initializeFile(); // Asegúrate de que el archivo local esté inicializado
    final file = await _getFile();
    final String content = await file.readAsString();
    final List<dynamic> data = jsonDecode(content);
    return data.map((usuario) => Usuario.fromMap(usuario)).toList();
  }

  // Agrega un nuevo usuario al archivo
  Future<void> addUsuario(Usuario usuario) async {
    final file = await _getFile();
    List<Usuario> usuarios = await fetchAll();
    usuarios.add(usuario);
    String updatedJson = jsonEncode(usuarios.map((usuario) => usuario.toJson()).toList());
    await file.writeAsString(updatedJson);
  }

  // Comprueba si un correo ya está registrado
  Future<bool> isEmailAlreadyRegistered(String email) async {
    List<Usuario> usuarios = await fetchAll();
    return usuarios.any((usuario) => usuario.email == email);
  }

  // Busca un usuario por su correo electrónico
  Future<Usuario> findByEmail(String email) async {
    List<Usuario> usuarios = await fetchAll();
    return usuarios.firstWhere((usuario) => usuario.email == email, orElse: () => throw Exception('Usuario no encontrado'));
  }

  // Genera un nuevo ID para un usuario
  Future<int> getNewId() async {
    List<Usuario> usuarios = await fetchAll();
    return usuarios.isNotEmpty ? usuarios.last.idUsuario + 1 : 1;
  }

  // Elimina un usuario por su ID
  Future<void> deleteUsuario(int idUsuario) async {
    final file = await _getFile();
    List<Usuario> usuarios = await fetchAll();
    usuarios.removeWhere((usuario) => usuario.idUsuario == idUsuario);
    String updatedJson = jsonEncode(usuarios.map((usuario) => usuario.toJson()).toList());
    await file.writeAsString(updatedJson);
  }

  // Actualiza la información de un usuario
  Future<void> updateUsuario(Usuario usuarioActualizado) async {
    final file = await _getFile();
    List<Usuario> usuarios = await fetchAll();
    int index = usuarios.indexWhere((usuario) => usuario.idUsuario == usuarioActualizado.idUsuario);
    if (index != -1) {
      usuarios[index] = usuarioActualizado;
      String updatedJson = jsonEncode(usuarios.map((usuario) => usuario.toJson()).toList());
      await file.writeAsString(updatedJson);
    }
  }

  // Obtiene el archivo JSON donde se almacenan los usuarios
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }
}
