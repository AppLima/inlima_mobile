import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inlima_mobile/models/service_http_response.dart';
import 'package:inlima_mobile/configs/constants.dart';

class StatusService {
  final String baseUrl = '${BASE_URL}';

  // Obtener todos los estados
  Future<ServiceHttpResponse?> getStatuses() async {
    final url = Uri.parse('${baseUrl}status');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception(
            "Error al obtener estados: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error en getStatuses: $e");
      return null;
    }
  }
}
