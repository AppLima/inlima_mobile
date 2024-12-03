import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart';
import 'package:inlima_mobile/models/service_http_response.dart';
import 'package:inlima_mobile/configs/constants.dart';

class UserService {
  final String baseUrl = '${BASE_URL}';
  final SesionController sesionController = SesionController();

  // Iniciar sesión
  Future<ServiceHttpResponse?> iniciarSesion(String email, String password) async {
    final url = Uri.parse('${baseUrl}iniciar_sesion');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception("Error al iniciar sesión: ${response.body}");
      }
    } catch (e) {
      print("Error en iniciarSesion: $e");
      return null;
    }
  }

  // Iniciar sesión con Google
  Future<ServiceHttpResponse?> iniciarSesionGoogle(String email) async {
    final url = Uri.parse('${baseUrl}iniciar_sesion_google');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception("Error al iniciar sesión con Google: ${response.body}");
      }
    } catch (e) {
      print("Error en iniciarSesionGoogle: $e");
      return null;
    }
  }

  // Cerrar sesión
  Future<ServiceHttpResponse?> cerrarSesion() async {
    final url = Uri.parse('${baseUrl}cerrar_sesion');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception("Error al cerrar sesión: ${response.body}");
      }
    } catch (e) {
      print("Error en cerrarSesion: $e");
      return null;
    }
  }

  // Actualizar cuenta
  Future<ServiceHttpResponse?> actualizarCuenta(Map<String, dynamic> data) async {
    final url = Uri.parse('${baseUrl}actualizar_cuenta');
    try {
      final token = sesionController.token;
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
        throw Exception("Error al actualizar cuenta: ${response.body}");
      }
    } catch (e) {
      print("Error en actualizarCuenta: $e");
      return null;
    }
  }

  // Obtener rol del usuario
  Future<ServiceHttpResponse?> obtenerRol() async {
    final url = Uri.parse('${baseUrl}obtener_rol');
    try {
      final token = sesionController.token;
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception("Error al obtener rol: ${response.body}");
      }
    } catch (e) {
      print("Error en obtenerRol: $e");
      return null;
    }
  }

  // Encontrar usuario por ID de ciudadano
  Future<ServiceHttpResponse?> encontrarUsuario(int citizenId) async {
    final url = Uri.parse('${baseUrl}encontrar_usuario');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'citizen_id': citizenId}),
      );

      if (response.statusCode == 200) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception("Error al encontrar usuario: ${response.body}");
      }
    } catch (e) {
      print("Error en encontrarUsuario: $e");
      return null;
    }
  }

  // Encontrar usuario por email
  Future<ServiceHttpResponse?> findUserByEmail(String email) async {
    final url = Uri.parse('${baseUrl}find_user_by_email');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception("Error al encontrar usuario por email: ${response.body}");
      }
    } catch (e) {
      print("Error en findUserByEmail: $e");
      return null;
    }
  }

  // Restablecer contraseña
  Future<ServiceHttpResponse?> resetPassword(String email, String password) async {
    final url = Uri.parse('${baseUrl}reset_password');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return ServiceHttpResponse.fromMap(jsonDecode(response.body));
      } else {
        throw Exception("Error al restablecer contraseña: ${response.body}");
      }
    } catch (e) {
      print("Error en resetPassword: $e");
      return null;
    }
  }

  // Aceptar términos y condiciones
  Future<ServiceHttpResponse?> setTermsConditions(Map<String, dynamic> data) async {
    final url = Uri.parse('${baseUrl}set_terms_conditions');
    try {
      final token = sesionController.token;
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
        throw Exception("Error al aceptar términos y condiciones: ${response.body}");
      }
    } catch (e) {
      print("Error en setTermsConditions: $e");
      return null;
    }
  }
}
