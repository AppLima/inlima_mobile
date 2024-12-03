import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inlima_mobile/models/service_http_response.dart';
import 'package:inlima_mobile/configs/constants.dart';

class DistrictService {
  final String baseUrl = '${BASE_URL}';

  // Obtener todos los distritos
  Future<ServiceHttpResponse?> getDistricts() async {
    final url = Uri.parse('${baseUrl}district');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception(
            "Error al obtener distritos: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error en getDistricts: $e");
      return null;
    }
  }
}
