import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inlima_mobile/configs/constants.dart';
import 'package:inlima_mobile/models/asunto.dart';

class SubjectApi {
  final String baseUrl = '${BASE_URL}';

  // Obtener todos los temas o materias
  Future<List<Asunto>?> getSubjects() async {
    final url = Uri.parse('${baseUrl}subject');
    List<Asunto> asuntos = [];
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        asuntos = data
          .map((map) => Asunto.fromMap(map as Map<String, dynamic>))
          .toList();
        return asuntos;
      } else {
        throw Exception(
            "Error al obtener temas: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error en getSubjects: $e");
      return null;
    }
  }
}
