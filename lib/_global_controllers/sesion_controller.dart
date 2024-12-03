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

  Future<void> guardarToken(String token) async {
    _token.value = token; 
    await _storage.write(
        key: 'auth_token',
        value: token); 
    await cargarDatosUsuarioDesdeToken(); 
  }

  Future<void> cargarToken() async {
    String? token =
        await _storage.read(key: 'auth_token'); 
    if (token != null) {
      _token.value = token; 
      await cargarDatosUsuarioDesdeToken(); 
    }
  }

  Future<void> borrarToken() async {
    _token.value = ''; 
    await _storage.delete(
        key: 'auth_token');
    _usuario.value = null; 
    _ciudadano.value = null; 
  }

  String get token => _token.value;

  Usuario? get usuario => _usuario.value;

  Ciudadano? get ciudadano => _ciudadano.value;

  Future<void> cargarDatosUsuarioDesdeToken() async {
    try {
      if (token.isEmpty || JwtDecoder.isExpired(token)) {
        print("Token no válido o expirado.");
        return;
      }

      final Map<String, dynamic> tokenData = JwtDecoder.decode(token);
      print(
          "Datos decodificados del token: $tokenData");
      if (!tokenData.containsKey('id') || !tokenData.containsKey('role')) {
        print("Token no contiene 'id' o 'role_id'.");
        return;
      }

      final int userId = tokenData['id'];
      final String email = tokenData['email'];
      final String nombre = tokenData['first_name'];
      final String apellido = tokenData['last_name'];
      final int roleId = tokenData['role'];
      final String? foto = tokenData['photo'];
      final int genderId = tokenData['gender'];

      print(
          "ID de usuario: $userId, Email: $email, Nombre: $nombre, Role ID: $roleId");

      if (roleId == 2) {
        final response =
            await ciudadanoService.fetchUsuarioYCiudadano(userId, token);
        if (response != null) {
          _usuario.value = response['usuario'];
          _ciudadano.value = response['ciudadano'];
        } else {
          print("No se encontraron datos para el usuario con ID: $userId");
        }
      } else {
        _usuario.value = Usuario(
          id: userId,
          email: email,
          password: '',
          nombre: nombre,
          apellido: apellido,
          foto: foto,
          rolId: roleId,
          genderId: genderId,
        );
        print("Usuario (Administrador) cargado desde el token: $_usuario");
      }
    } catch (e) {
      print("Error al cargar los datos del usuario y ciudadano: $e");
    }
  }
}