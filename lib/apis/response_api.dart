import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart';
import 'package:inlima_mobile/models/service_http_response.dart';
import 'package:inlima_mobile/configs/constants.dart';

class ResponseService {
  final String baseUrl = '${BASE_URL}';
  final SesionController sesionController = Get.find<SesionController>();

  // Método para registrar una respuesta
  Future<ServiceHttpResponse?> recordResponse(Map<String, dynamic> data) async {
    print("TOKEN========== ${sesionController.token}");
    final url = Uri.parse('${baseUrl}record_response');
    try {
      final token = sesionController.token;
      if (token.isEmpty) {
        throw Exception("Token no disponible. Inicia sesión nuevamente.");
      }
      print("JSON DATA RESPONSE ======== ${jsonEncode(data)}");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception(
            "Error al registrar respuesta: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error en recordResponse: $e");
      return null;
    }
  }
}
