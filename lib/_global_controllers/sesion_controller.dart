import 'package:get/get.dart';
import 'package:inlima_mobile/models/usuario.dart';
import 'package:inlima_mobile/models/ciudadano.dart';
import 'package:inlima_mobile/services/ciudadano_service.dart';

class SesionController extends GetxController {
  final _usuario = Usuario(
    id: 0, 
    email: '', 
    password: '', 
    nombre: '',
    apellido: '', 
    rolId: 0, 
    sexo: '', // Cambiamos sexoId por sexo, que será una cadena ("masculino", "femenino")
    foto: '',
    distritoId: 0, 
  ).obs;

  final _ciudadano = Ciudadano(
    id: 0,
    dni: '',
    numero: '',
    usuarioId: 0,
  ).obs;

  final CiudadanoService ciudadanoService = CiudadanoService();

  @override
  void onInit() {
    super.onInit();
  }

  // Método para iniciar sesión
  Future<void> iniciarSesion(Usuario usuario) async {
    // Actualizamos el usuario con los datos proporcionados, incluyendo el sexo y distritoId
    _usuario.value = Usuario(
      id: usuario.id,
      email: usuario.email,
      password: usuario.password, // Guardamos la contraseña
      nombre: usuario.nombre,
      apellido: usuario.apellido,
      foto: usuario.foto,
      rolId: usuario.rolId,
      sexo: usuario.sexo, // Asignamos el valor del sexo ("masculino", "femenino", etc.)
      distritoId: usuario.distritoId, // Incluimos el distritoId
    );

    // Obtenemos los datos del ciudadano asociado al usuario
    try {
      Ciudadano? ciudadano = await ciudadanoService.obtenerCiudadanoPorUsuarioId(usuario.id);
      if (ciudadano != null) {
        _ciudadano.value = ciudadano; // Guardamos el ciudadano
      } else {
        print('No se encontró el ciudadano para este usuario.');
      }
    } catch (e) {
      print('Error al obtener los datos del ciudadano: $e');
    }
  }

  // Getter para acceder al usuario actual
  Usuario get usuario => _usuario.value;

  // Getter para acceder al ciudadano actual
  Ciudadano get ciudadano => _ciudadano.value;

  // Método para cerrar sesión
  void cerrarSesion() {
    // Reseteamos el usuario a valores por defecto
    _usuario.value = Usuario(
      id: 0,
      email: '',
      password: '',
      nombre: '',
      apellido: '',
      rolId: 0,
      sexo: '', // Reseteamos el campo sexo
      foto: '',
      distritoId: 0, // Reseteamos el distritoId
    );

    // Reseteamos los datos del ciudadano a valores por defecto
    _ciudadano.value = Ciudadano(
      id: 0,
      dni: '',
      numero: '',
      usuarioId: 0,
    );
  }
}
