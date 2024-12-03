import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inlima_mobile/models/service_http_response.dart';
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart';
import 'package:inlima_mobile/configs/constants.dart';

class SurveyService {
  final String baseUrl = '${BASE_URL}';
  final SesionController sesionController = SesionController();

  // Crear una encuesta
  Future<ServiceHttpResponse?> createSurvey(Map<String, dynamic> data) async {
    final url = Uri.parse('${baseUrl}create_survey');
    try {
      final token = sesionController.token;
      if (token.isEmpty) {
        throw Exception("Token no disponible. Inicia sesión nuevamente.");
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception(
            "Error al crear encuesta: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error en createSurvey: $e");
      return null;
    }
  }

  // Obtener todas las encuestas
  Future<ServiceHttpResponse?> getSurveys() async {
    final url = Uri.parse('${baseUrl}survey');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception(
            "Error al obtener encuestas: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error en getSurveys: $e");
      return null;
    }
  }
}
