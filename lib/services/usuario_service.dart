import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';
import '../configs/constants.dart'; // Asegúrate de tener `BASE_URL` aquí
import '../models/service_http_response.dart';

class UsuarioService {
  final String baseUrl = '${BASE_URL}';

  // Iniciar sesión
  Future<ServiceHttpResponse?> iniciarSesion(
      String email, String password) async {
    final url = Uri.parse('${baseUrl}iniciar_sesion');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      return ServiceHttpResponse(
          status: response.statusCode,
          body: response.statusCode == 200
              ? jsonDecode(response.body)
              : response.body);
    } catch (e) {
      return ServiceHttpResponse(
          status: 503, body: 'Error al comunicarse con el servidor: $e');
    }
  }

  Future<ServiceHttpResponse?> registerUser(Map<String, dynamic> data) async {
    final url = Uri.parse('${baseUrl}register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return ServiceHttpResponse(
          status: response.statusCode,
          body: jsonDecode(response.body), // Decodificar el cuerpo completo
        );
      } else {
        final errorBody = jsonDecode(response.body); // Decodificar error
        return ServiceHttpResponse(
          status: response.statusCode,
          body: errorBody, // Retornar el error completo para capturar `message`
        );
      }
    } catch (e) {
      return ServiceHttpResponse(
        status: 503,
        body: 'Error al comunicarse con el servidor: $e',
      );
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
      return ServiceHttpResponse(
          status: response.statusCode,
          body: response.statusCode == 200
              ? jsonDecode(response.body)
              : response.body);
    } catch (e) {
      return ServiceHttpResponse(
          status: 503, body: 'Error al comunicarse con el servidor: $e');
    }
  }

  // Cerrar sesión
  Future<ServiceHttpResponse?> cerrarSesion() async {
    final url = Uri.parse('${baseUrl}cerrar_sesion');
    try {
      final response = await http.delete(url);
      return ServiceHttpResponse(
          status: response.statusCode,
          body: response.statusCode == 200
              ? 'Sesión cerrada correctamente'
              : response.body);
    } catch (e) {
      return ServiceHttpResponse(
          status: 503, body: 'Error al comunicarse con el servidor: $e');
    }
  }

  // Actualizar cuenta
  Future<ServiceHttpResponse?> actualizarCuenta(
      String token, Map<String, dynamic> datosActualizados) async {
    final url = Uri.parse('${baseUrl}actualizar_cuenta');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: jsonEncode(datosActualizados),
      );
      return ServiceHttpResponse(
          status: response.statusCode, body: jsonDecode(response.body));
    } catch (e) {
      return ServiceHttpResponse(
          status: 503, body: 'Error al comunicarse con el servidor: $e');
    }
  }

  // Obtener rol de usuario
  Future<ServiceHttpResponse?> obtenerRol(String token) async {
    final url = Uri.parse('${baseUrl}obtener_rol');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': token},
      );
      return ServiceHttpResponse(
          status: response.statusCode, body: jsonDecode(response.body));
    } catch (e) {
      return ServiceHttpResponse(
          status: 503, body: 'Error al comunicarse con el servidor: $e');
    }
  }

  // Buscar usuario por ID
  Future<ServiceHttpResponse?> encontrarUsuario(int citizenId) async {
    final url = Uri.parse('${baseUrl}encontrar_usuario');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'citizen_id': citizenId}),
      );
      return ServiceHttpResponse(
          status: response.statusCode, body: jsonDecode(response.body));
    } catch (e) {
      return ServiceHttpResponse(
          status: 503, body: 'Error al comunicarse con el servidor: $e');
    }
  }

  // Buscar usuario por email
  Future<ServiceHttpResponse?> findUserByEmail(String email) async {
    final url = Uri.parse('${baseUrl}find_user_by_email');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      return ServiceHttpResponse(
          status: response.statusCode, body: jsonDecode(response.body));
    } catch (e) {
      return ServiceHttpResponse(
          status: 503, body: 'Error al comunicarse con el servidor: $e');
    }
  }

  // Resetear contraseña
  Future<ServiceHttpResponse?> resetPassword(
      String email, String password) async {
    final url = Uri.parse('${baseUrl}reset_password');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      return ServiceHttpResponse(
          status: response.statusCode, body: jsonDecode(response.body));
    } catch (e) {
      return ServiceHttpResponse(
          status: 503, body: 'Error al comunicarse con el servidor: $e');
    }
  }

  // Aceptar términos y condiciones
  Future<ServiceHttpResponse?> setTermsConditions(
      String token, Map<String, dynamic> data) async {
    final url = Uri.parse('${baseUrl}set_terms_conditions');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: jsonEncode(data),
      );
      return ServiceHttpResponse(
          status: response.statusCode, body: jsonDecode(response.body));
    } catch (e) {
      return ServiceHttpResponse(
          status: 503, body: 'Error al comunicarse con el servidor: $e');
    }
  }
}
