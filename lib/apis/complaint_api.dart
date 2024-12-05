import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart';
import 'package:inlima_mobile/models/service_http_response.dart';
import 'package:inlima_mobile/configs/constants.dart';
import 'package:inlima_mobile/models/queja.dart';

class ComplaintApi {
  final String baseUrl = '${BASE_URL}';
  final SesionController sesionController = Get.find<SesionController>();

  // Agregar una queja
  Future<bool?> addComplaint(Map<String, dynamic> data) async {
    final url = Uri.parse('${baseUrl}complaint');
    try {
      final token = sesionController.token;
      print(token);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception("Error al agregar la queja: ${response.body}");
      }
    } catch (e) {
      print("Error en addComplaint: $e");
      return null;
    }
  }

  // Obtener ubicación de una queja por ID
  Future<ServiceHttpResponse?> getComplaintLocation(int id) async {
    final url = Uri.parse('${baseUrl}complaint/$id/location');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception("Error al obtener ubicación: ${response.body}");
      }
    } catch (e) {
      print("Error en getComplaintLocation: $e");
      return null;
    }
  }

  // Obtener distrito de una queja por ID
  Future<ServiceHttpResponse?> getComplaintDistrict(int id) async {
    final url = Uri.parse('${baseUrl}complaint/$id/district');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception("Error al obtener distrito: ${response.body}");
      }
    } catch (e) {
      print("Error en getComplaintDistrict: $e");
      return null;
    }
  }

  // Obtener quejas filtradas
  Future<List<Queja>?> getFilteredComplaints(List<int> asuntos) async {
    final url = Uri.parse('${baseUrl}complaints/filtered');
    List<Queja> quejas = [];
    try {
      final token = sesionController.token;
      print("XDDDDD");
      print(asuntos);

      final filters = {
        'subject_ids': asuntos,
        'district_ids': [1],
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode(filters),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        quejas = data
          .map((map) => Queja.fromMap(map as Map<String, dynamic>))
          .toList();
        return quejas;
      } else {
        throw Exception("Error al obtener quejas filtradas: ${response.body}");
      }
    } catch (e) {
      print("Error en getFilteredComplaints: $e");
      return null;
    }
  }

  // Obtener detalles de una queja por ID
  Future<ServiceHttpResponse?> getComplaintDetails(int id) async {
    final url = Uri.parse('${baseUrl}complaint/$id/details');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception("Error al obtener detalles: ${response.body}");
      }
    } catch (e) {
      print("Error en getComplaintDetails: $e");
      return null;
    }
  }

  Future<List<Queja>?> getUserComplaints() async {
    final url = Uri.parse('${baseUrl}user/complaints');
    List<Queja> quejas = [];
    try {
      final token = sesionController.token;
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        quejas = data
          .map((map) => Queja.fromMap(map as Map<String, dynamic>))
          .toList();
        return quejas;
      } else {
        throw Exception("Error al obtener quejas del usuario: ${response.body}");
      }
    } catch (e) {
      print("Error en getUserComplaints: $e");
      return null;
    }
  }
}
