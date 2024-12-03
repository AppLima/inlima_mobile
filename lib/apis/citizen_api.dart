import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart';
import 'package:inlima_mobile/models/service_http_response.dart';
import 'package:inlima_mobile/configs/constants.dart';

class CitizenService {
  final String baseUrl = '${BASE_URL}';
  final SesionController sesionController = SesionController();

  // Registro de ciudadano
  Future<ServiceHttpResponse?> registerCitizen(Map<String, dynamic> data) async {
    final url = Uri.parse('${baseUrl}register');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception(
            "Error al registrar ciudadano: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error en registerCitizen: $e");
      return null;
    }
  }

  // Buscar ciudadano por el ID del usuario
  Future<ServiceHttpResponse?> getCitizenByUserId(int userId) async {
    final url = Uri.parse('${baseUrl}citizen/user/$userId');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception(
            "Error al buscar ciudadano por ID: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error en getCitizenByUserId: $e");
      return null;
    }
  }

  // Actualizar el perfil de un ciudadano
  Future<ServiceHttpResponse?> updateCitizenProfile(Map<String, dynamic> data) async {
    final url = Uri.parse('${baseUrl}citizen/update');
    try {
      final token = sesionController.token;
      if (token.isEmpty) {
        throw Exception("Token no disponible. Inicia sesión nuevamente.");
      }

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception(
            "Error al actualizar perfil: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error en updateCitizenProfile: $e");
      return null;
    }
  }
}
