import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:inlima_mobile/models/ciudadano.dart';

class CiudadanoService {
  final String _fileName = 'ciudadanos10.json'; // Archivo local donde se guardarán las modificaciones
  bool _initialized = false;

  // Método para inicializar el archivo local si no existe
  Future<void> _initializeFile() async {
    final file = await _getFile();
    if (!await file.exists()) {
      // Si el archivo no existe, copiar el contenido de assets/json/ciudadanos.json
      final String content = await rootBundle.loadString('assets/json/ciudadanos.json');
      await file.writeAsString(content);
    }
    _initialized = true;
  }

  Future<List<Ciudadano>> fetchAll() async {
    if (!_initialized) await _initializeFile(); // Asegúrate de que el archivo local esté inicializado
    final file = await _getFile();
    if (!await file.exists()) {
      return [];
    }
    final String content = await file.readAsString();
    final List<dynamic> data = jsonDecode(content);
    return data.map((ciudadano) => Ciudadano.fromMap(ciudadano)).toList();
  }

  Future<void> addCiudadano(Ciudadano ciudadano) async {
    final file = await _getFile();
    List<Ciudadano> ciudadanos = await fetchAll();
    ciudadanos.add(ciudadano);
    String updatedJson = jsonEncode(ciudadanos.map((ciudadano) => ciudadano.toJson()).toList());
    await file.writeAsString(updatedJson);
  }

  Future<int> getNewId() async {
    List<Ciudadano> ciudadanos = await fetchAll();
    return ciudadanos.isNotEmpty ? ciudadanos.last.id + 1 : 1;
  }

  Future<bool> isDniAlreadyRegistered(String dni) async {
    List<Ciudadano> ciudadanos = await fetchAll();
    return ciudadanos.any((ciudadano) => ciudadano.dni == dni);
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<Ciudadano?> obtenerCiudadanoPorUsuarioId(int idUsuario) async {
    List<Ciudadano> ciudadanos = await fetchAll();
    try {
      return ciudadanos.firstWhere((ciudadano) => ciudadano.usuarioId == idUsuario);
    } catch (e) {
      return null;
    }
  }
}
