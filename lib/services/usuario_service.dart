import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:inlima_mobile/models/usuario.dart';

class UsuarioService {
  final String _fileName = 'usuarios3.json';

  Future<List<Usuario>> fetchAll() async {
    final file = await _getFile();
    if (!await file.exists()) {
      return [];
    }
    final String content = await file.readAsString();
    final List<dynamic> data = jsonDecode(content);
    return data.map((user) => Usuario.fromMap(user)).toList();
  }

  Future<void> addUsuario(Usuario usuario) async {
    final file = await _getFile();
    List<Usuario> usuarios = await fetchAll();
    usuarios.add(usuario);

    String updatedJson =
        jsonEncode(usuarios.map((user) => user.toJson()).toList());
    await file.writeAsString(updatedJson);
  }

  Future<int> getNewId() async {
    List<Usuario> usuarios = await fetchAll();
    return usuarios.isNotEmpty ? usuarios.last.idUsuario + 1 : 1;
  }

  Future<bool> isEmailAlreadyRegistered(String email) async {
    List<Usuario> usuarios = await fetchAll();
    return usuarios.any((usuario) => usuario.email == email);
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }
}
