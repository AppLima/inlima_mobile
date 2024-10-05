import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:inlima_mobile/models/ciudadano.dart';

class CiudadanoService {
  final String _fileName = 'ciudadanos3.json';
  Future<List<Ciudadano>> fetchAll() async {
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
    String updatedJson =
        jsonEncode(ciudadanos.map((ciudadano) => ciudadano.toJson()).toList());
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
}
