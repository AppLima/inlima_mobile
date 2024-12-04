import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:inlima_mobile/models/usuario.dart';
import 'package:path_provider/path_provider.dart';
import 'package:inlima_mobile/models/ciudadano.dart';
import '../configs/constants.dart';
import '../models/service_http_response.dart';

class CiudadanoService {
  final String baseUrl = '${BASE_URL}';
  Future<Map<String, dynamic>?> fetchUsuarioYCiudadano(
      int userId, String token) async {
    final url = Uri.parse('$baseUrl/citizen/user/$userId'); // Endpoint único

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token', // Token JWT para la autenticación
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      if (body['success'] == true) {
        return {
          'usuario': Usuario.fromMap(body['usuario']), // Parsear el usuario
          'ciudadano':
              Ciudadano.fromMap(body['ciudadano']), // Parsear el ciudadano
        };
      } else {
        print("Error en la respuesta del backend: ${body['message']}");
        return null;
      }
    } else {
      print("Error al realizar la solicitud: ${response.statusCode}");
      return null;
    }
  }

  // Método para actualizar ciudadano y usuario
  Future<Map<String, dynamic>> updateCiudadanoYUsuario(
      Map<String, dynamic> data) async {
    final url =
        Uri.parse('${baseUrl}citizen/update'); // Endpoint para actualizar
    print(data);
    try {
      // Realizar la solicitud PUT
      final response = await http.put(
        url,
        headers: {
          'Content-Type':
              'application/json', // Solo incluyes encabezados necesarios
        },
        body: jsonEncode(data), // Convertir datos a JSON
      );
      print(response);
      // Manejar la respuesta
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['success'] == true) {
          return {'success': true, 'message': body['message']};
        } else {
          return {'success': false, 'message': body['message']};
        }
      } else {
        print('Error en la solicitud: ${response.statusCode}');
        return {
          'success': false,
          'message': 'Error en la solicitud al servidor'
        };
      }
    } catch (e) {
      print('Error durante la actualización: $e');
      return {'success': false, 'message': 'Error de conexión con el servidor'};
    }
  }

  // final String _fileName = 'ciudadanos10.json'; // Archivo local donde se guardarán las modificaciones
  // bool _initialized = false;

  // // Método para inicializar el archivo local si no existe
  // Future<void> _initializeFile() async {
  //   final file = await _getFile();
  //   if (!await file.exists()) {
  //     // Si el archivo no existe, copiar el contenido de assets/json/ciudadanos.json
  //     final String content = await rootBundle.loadString('assets/json/ciudadanos.json');
  //     await file.writeAsString(content);
  //   }
  //   _initialized = true;
  // }

  // Future<List<Ciudadano>> fetchAll() async {
  //   if (!_initialized) await _initializeFile(); // Asegúrate de que el archivo local esté inicializado
  //   final file = await _getFile();
  //   if (!await file.exists()) {
  //     return [];
  //   }
  //   final String content = await file.readAsString();
  //   final List<dynamic> data = jsonDecode(content);
  //   return data.map((ciudadano) => Ciudadano.fromMap(ciudadano)).toList();
  // }

  // Future<void> addCiudadano(Ciudadano ciudadano) async {
  //   final file = await _getFile();
  //   List<Ciudadano> ciudadanos = await fetchAll();
  //   ciudadanos.add(ciudadano);
  //   String updatedJson = jsonEncode(ciudadanos.map((ciudadano) => ciudadano.toJson()).toList());
  //   await file.writeAsString(updatedJson);
  // }

  // Future<int> getNewId() async {
  //   List<Ciudadano> ciudadanos = await fetchAll();
  //   return ciudadanos.isNotEmpty ? ciudadanos.last.id + 1 : 1;
  // }

  // Future<bool> isDniAlreadyRegistered(String dni) async {
  //   List<Ciudadano> ciudadanos = await fetchAll();
  //   return ciudadanos.any((ciudadano) => ciudadano.dni == dni);
  // }

  // Future<File> _getFile() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return File('${directory.path}/$_fileName');
  // }

  // Future<Ciudadano?> obtenerCiudadanoPorUsuarioId(int idUsuario) async {
  //   List<Ciudadano> ciudadanos = await fetchAll();
  //   try {
  //     return ciudadanos.firstWhere((ciudadano) => ciudadano.userId == idUsuario);
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
