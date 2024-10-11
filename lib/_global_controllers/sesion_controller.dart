import 'package:get/get.dart';
import 'package:inlima_mobile/models/usuario.dart';

class SesionController extends GetxController {
  
  var _usuario = Usuario(
    idUsuario: 0, 
    email: '', 
    password: '', 
    nombre: '',
    apellidoPaterno: '', 
    apellidoMaterno: '', 
    rolId: 0,
    sexoId: 0,
  ).obs;

  @override
  void onInit() {
    super.onInit();
  }

  // Método para iniciar sesión
void iniciarSesion(Usuario usuario) {
  // Actualizamos el usuario con los datos proporcionados
  _usuario.value = Usuario(
    idUsuario: usuario.idUsuario,
    email: usuario.email,
    password: "",
    nombre: usuario.nombre,
    apellidoPaterno: usuario.apellidoPaterno,
    apellidoMaterno: usuario.apellidoMaterno,
    foto: usuario.foto,
    rolId: usuario.rolId,
    sexoId: usuario.sexoId,
  );
}

  // Getter para acceder al usuario
  Usuario get usuario => _usuario.value;

  get usuarioActual => null;

  // Método para cerrar sesión
  void cerrarSesion() {
    // Reseteamos el usuario a valores por defecto
    _usuario.value = Usuario(
      idUsuario: 0,
      email: '',
      password: '',
      nombre: '',
      apellidoPaterno: '',
      apellidoMaterno: '',
      rolId: 0,
      sexoId: 0,
    );
  }
}
