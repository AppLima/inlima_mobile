import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:inlima_mobile/models/usuario.dart';
import 'package:inlima_mobile/models/ciudadano.dart';
import 'package:inlima_mobile/services/usuario_service.dart';
import 'package:inlima_mobile/services/ciudadano_service.dart';

class SesionController extends GetxController {
  final _token = ''.obs; 
  final _storage =
      const FlutterSecureStorage(); 

  final _usuario = Rxn<Usuario>(); 
  final _ciudadano = Rxn<Ciudadano>(); 

  final UsuarioService usuarioService = UsuarioService();
  final CiudadanoService ciudadanoService = CiudadanoService();

  // Método para guardar el token
  Future<void> guardarToken(String token) async {
    _token.value = token; 
    await _storage.write(
        key: 'auth_token',
        value: token); 
    await cargarDatosUsuarioDesdeToken(); 
  }

  // Método para cargar el token desde el almacenamiento seguro
  Future<void> cargarToken() async {
    String? token =
        await _storage.read(key: 'auth_token'); 
    if (token != null) {
      _token.value = token; 
      await cargarDatosUsuarioDesdeToken(); 
    }
  }

  // Método para borrar el token, reemplaza al cerrar sesion
  Future<void> borrarToken() async {
    _token.value = ''; 
    await _storage.delete(
        key: 'auth_token'); // Borra el token del almacenamiento seguro
    _usuario.value = null; 
    _ciudadano.value = null; 
  }

  // Getter para el token actual
  String get token => _token.value;

  // Getter para el usuario actual
  Usuario? get usuario => _usuario.value;

  // Getter para el ciudadano actual
  Ciudadano? get ciudadano => _ciudadano.value;

  // Método para cargar los datos del usuario y ciudadano desde el token
  Future<void> cargarDatosUsuarioDesdeToken() async {
    try {
      if (token.isEmpty || JwtDecoder.isExpired(token)) {
        print("Token no válido o expirado.");
        return;
      }

      // Decodificar el token para obtener el ID del usuario
      final Map<String, dynamic> tokenData = JwtDecoder.decode(token);
      final int userId = tokenData['id'];

      // Usar el método del CiudadanoService para obtener los datos
      final response =
          await ciudadanoService.fetchUsuarioYCiudadano(userId, token);

      if (response != null) {
        _usuario.value = response['usuario']; // Guardar el usuario
        _ciudadano.value = response['ciudadano']; // Guardar el ciudadano
      } else {
        print("No se encontraron datos para el usuario con ID: $userId");
      }
    } catch (e) {
      print("Error al cargar los datos del usuario y ciudadano: $e");
    }
  }
}

// import 'package:get/get.dart';
// import 'package:inlima_mobile/models/usuario.dart';
// import 'package:inlima_mobile/models/ciudadano.dart';
// import 'package:inlima_mobile/services/ciudadano_service.dart';

// class SesionController extends GetxController {
//   final _usuario = Usuario(
//     id: 0, 
//     email: '', 
//     password: '', 
//     nombre: '',
//     apellido: '', 
//     rolId: 0, 
//     sexo: '', // Cambiamos sexoId por sexo, que será una cadena ("masculino", "femenino")
//     foto: '',
//     distritoId: 0, 
//   ).obs;

//   final _ciudadano = Ciudadano(
//     id: 0,
//     dni: '',
//     numero: '',
//     usuarioId: 0,
//   ).obs;

//   final CiudadanoService ciudadanoService = CiudadanoService();

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   // Método para iniciar sesión
//   Future<void> iniciarSesion(Usuario usuario) async {
//     // Actualizamos el usuario con los datos proporcionados, incluyendo el sexo y distritoId
//     _usuario.value = Usuario(
//       id: usuario.id,
//       email: usuario.email,
//       password: usuario.password, // Guardamos la contraseña
//       nombre: usuario.nombre,
//       apellido: usuario.apellido,
//       foto: usuario.foto,
//       rolId: usuario.rolId,
//       sexo: usuario.sexo, // Asignamos el valor del sexo ("masculino", "femenino", etc.)
//       distritoId: usuario.distritoId, // Incluimos el distritoId
//     );

//     // Obtenemos los datos del ciudadano asociado al usuario
//     try {
//       Ciudadano? ciudadano = await ciudadanoService.obtenerCiudadanoPorUsuarioId(usuario.id);
//       if (ciudadano != null) {
//         _ciudadano.value = ciudadano; // Guardamos el ciudadano
//       } else {
//         print('No se encontró el ciudadano para este usuario.');
//       }
//     } catch (e) {
//       print('Error al obtener los datos del ciudadano: $e');
//     }
//   }

//   // Getter para acceder al usuario actual
//   Usuario get usuario => _usuario.value;

//   // Getter para acceder al ciudadano actual
//   Ciudadano get ciudadano => _ciudadano.value;

//   // Método para cerrar sesión
//   void cerrarSesion() {
//     // Reseteamos el usuario a valores por defecto
//     _usuario.value = Usuario(
//       id: 0,
//       email: '',
//       password: '',
//       nombre: '',
//       apellido: '',
//       rolId: 0,
//       sexo: '', // Reseteamos el campo sexo
//       foto: '',
//       distritoId: 0, // Reseteamos el distritoId
//     );

//     // Reseteamos los datos del ciudadano a valores por defecto
//     _ciudadano.value = Ciudadano(
//       id: 0,
//       dni: '',
//       numero: '',
//       usuarioId: 0,
//     );
//   }
// }