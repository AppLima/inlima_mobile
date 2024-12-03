import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart';
import 'package:inlima_mobile/models/service_http_response.dart';
import 'package:inlima_mobile/configs/constants.dart';

class ChangeService {
  final String baseUrl = '${BASE_URL}';
  final SesionController sesionController = SesionController();

  // Método para registrar un cambio
  Future<ServiceHttpResponse?> recordChange(Map<String, dynamic> data) async {
    final url = Uri.parse('${baseUrl}record_change');
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
            "Error al registrar el cambio: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error en recordChange: $e");
      return null;
    }
  }
}
