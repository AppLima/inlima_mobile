
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';
import '../configs/constants.dart'; // Asegúrate de tener `BASE_URL` aquí
import '../models/service_http_response.dart';

class UsuarioService {
  final String baseUrl = '${BASE_URL}';

  // Iniciar sesión
  Future<ServiceHttpResponse?> iniciarSesion(String email, String password) async {
    final url = Uri.parse('${baseUrl}iniciar_sesion');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      return ServiceHttpResponse(
          status: response.statusCode,
          body: response.statusCode == 200 ? jsonDecode(response.body) : response.body);
    } catch (e) {
      return ServiceHttpResponse(status: 503, body: 'Error al comunicarse con el servidor: $e');
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
          body: response.statusCode == 200 ? jsonDecode(response.body) : response.body);
    } catch (e) {
      return ServiceHttpResponse(status: 503, body: 'Error al comunicarse con el servidor: $e');
    }
  }

  // Cerrar sesión
  Future<ServiceHttpResponse?> cerrarSesion() async {
    final url = Uri.parse('${baseUrl}cerrar_sesion');
    try {
      final response = await http.delete(url);
      return ServiceHttpResponse(
          status: response.statusCode,
          body: response.statusCode == 200 ? 'Sesión cerrada correctamente' : response.body);
    } catch (e) {
      return ServiceHttpResponse(status: 503, body: 'Error al comunicarse con el servidor: $e');
    }
  }

  // Actualizar cuenta
  Future<ServiceHttpResponse?> actualizarCuenta(
      String token, Map<String, dynamic> datosActualizados) async {
    final url = Uri.parse('${baseUrl}actualizar_cuenta');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token
        },
        body: jsonEncode(datosActualizados),
      );
      return ServiceHttpResponse(
          status: response.statusCode, body: jsonDecode(response.body));
    } catch (e) {
      return ServiceHttpResponse(status: 503, body: 'Error al comunicarse con el servidor: $e');
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
      return ServiceHttpResponse(status: 503, body: 'Error al comunicarse con el servidor: $e');
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
      return ServiceHttpResponse(status: 503, body: 'Error al comunicarse con el servidor: $e');
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
      return ServiceHttpResponse(status: 503, body: 'Error al comunicarse con el servidor: $e');
    }
  }

  // Resetear contraseña
  Future<ServiceHttpResponse?> resetPassword(String email, String password) async {
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
      return ServiceHttpResponse(status: 503, body: 'Error al comunicarse con el servidor: $e');
    }
  }

  // Aceptar términos y condiciones
  Future<ServiceHttpResponse?> setTermsConditions(String token, Map<String, dynamic> data) async {
    final url = Uri.parse('${baseUrl}set_terms_conditions');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token
        },
        body: jsonEncode(data),
      );
      return ServiceHttpResponse(
          status: response.statusCode, body: jsonDecode(response.body));
    } catch (e) {
      return ServiceHttpResponse(status: 503, body: 'Error al comunicarse con el servidor: $e');
    }
  }
}

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:path_provider/path_provider.dart';
// import 'package:inlima_mobile/models/usuario.dart';

// class UsuarioService {
//   final String _fileName = 'usuarios10.json'; // Archivo local donde se guardarán las modificaciones
//   bool _initialized = false;

//   // Método para inicializar el archivo local si no existe
//   Future<void> _initializeFile() async {
//     final file = await _getFile();
//     if (!await file.exists()) {
//       // Si el archivo no existe, copiar el contenido de assets/usuarios.json
//       final String content = await rootBundle.loadString('assets/json/usuarios.json');
//       await file.writeAsString(content);
//     }
//     _initialized = true;
//   }

//   // Obtiene todos los usuarios desde el archivo
//   Future<List<Usuario>> fetchAll() async {
//     if (!_initialized) await _initializeFile(); // Asegúrate de que el archivo local esté inicializado
//     final file = await _getFile();
//     final String content = await file.readAsString();
//     final List<dynamic> data = jsonDecode(content);
//     return data.map((usuario) => Usuario.fromMap(usuario)).toList();
//   }

//   // Agrega un nuevo usuario al archivo
//   Future<void> addUsuario(Usuario usuario) async {
//     final file = await _getFile();
//     List<Usuario> usuarios = await fetchAll();
//     usuarios.add(usuario);
//     String updatedJson = jsonEncode(usuarios.map((usuario) => usuario.toJson()).toList());
//     await file.writeAsString(updatedJson);
//   }

//   // Comprueba si un correo ya está registrado
//   Future<bool> isEmailAlreadyRegistered(String email) async {
//     List<Usuario> usuarios = await fetchAll();
//     return usuarios.any((usuario) => usuario.email == email);
//   }

//   // Busca un usuario por su correo electrónico
//   Future<Usuario> findByEmail(String email) async {
//     List<Usuario> usuarios = await fetchAll();
//     return usuarios.firstWhere((usuario) => usuario.email == email, orElse: () => throw Exception('Usuario no encontrado'));
//   }

//   // Genera un nuevo ID para un usuario
//   Future<int> getNewId() async {
//     List<Usuario> usuarios = await fetchAll();
//     return usuarios.isNotEmpty ? usuarios.last.idUsuario + 1 : 1;
//   }

//   // Elimina un usuario por su ID
//   Future<void> deleteUsuario(int idUsuario) async {
//     final file = await _getFile();
//     List<Usuario> usuarios = await fetchAll();
//     usuarios.removeWhere((usuario) => usuario.idUsuario == idUsuario);
//     String updatedJson = jsonEncode(usuarios.map((usuario) => usuario.toJson()).toList());
//     await file.writeAsString(updatedJson);
//   }

//   // Actualiza la información de un usuario
//   Future<void> updateUsuario(Usuario usuarioActualizado) async {
//     final file = await _getFile();
//     List<Usuario> usuarios = await fetchAll();
//     int index = usuarios.indexWhere((usuario) => usuario.idUsuario == usuarioActualizado.idUsuario);
//     if (index != -1) {
//       usuarios[index] = usuarioActualizado;
//       String updatedJson = jsonEncode(usuarios.map((usuario) => usuario.toJson()).toList());
//       await file.writeAsString(updatedJson);
//     }
//   }

//   // Obtiene el archivo JSON donde se almacenan los usuarios
//   Future<File> _getFile() async {
//     final directory = await getApplicationDocumentsDirectory();
//     return File('${directory.path}/$_fileName');
//   }
// }
