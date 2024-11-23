import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart';
import 'package:inlima_mobile/models/ciudadano.dart';
import 'package:inlima_mobile/models/usuario.dart';
import 'package:inlima_mobile/models/distrito.dart'; // Importa el modelo Distrito
import 'package:inlima_mobile/services/usuario_service.dart';
import 'package:inlima_mobile/services/ciudadano_service.dart';
import 'package:inlima_mobile/services/distrito_service.dart'; // Importa el servicio Distrito

class InicioController {
  ValueNotifier<bool> isLogin = ValueNotifier(true);
  ValueNotifier<int> selectedSexoId =
      ValueNotifier(0); // Maneja el ID del sexo (0 por defecto)

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dniController = TextEditingController();
  final nombresController = TextEditingController();
  final apellidoPaternoController = TextEditingController();
  final apellidoMaternoController = TextEditingController();
  final telefonoController = TextEditingController();
  final distritoController = TextEditingController();

  final UsuarioService usuarioService = UsuarioService();
  final CiudadanoService ciudadanoService = CiudadanoService();
  final DistritoService distritoService =
      DistritoService(); // Servicio para cargar distritos

  final SesionController sesion = Get.put(SesionController());

  List<Distrito> distritos = []; // Lista de distritos
  Distrito? selectedDistrito; // Distrito seleccionado por nombre


  InicioController({required bool isRegister})
      : isLogin = ValueNotifier(!isRegister);
      
  String getWelcomeText() {
    return isLogin.value ? 'Bienvenido a inLima' : 'Regístrate en inLima';
  }

  String getButtonText() {
    return isLogin.value ? 'Entrar' : 'Registrarse';
  }

  // Método para cargar distritos desde el servicio
  Future<void> fetchDistritos(BuildContext context) async {
    try {
      distritos = await distritoService.fetchAll();
      if (distritos.isEmpty) {
        print("No se encontraron distritos");
      } else {
        print("Distritos cargados: $distritos");
      }
      selectedDistrito = null; // Inicializamos selectedDistrito como null
    } catch (e) {
      print("Error al cargar distritos: $e");
      _showError(
          context, "No se pudieron cargar los distritos. Inténtalo más tarde.");
    }
  }

  // Método para manejar el cambio del distrito seleccionado por nombre
  void onDistritoChanged(BuildContext context, Distrito? distrito) {
    if (distrito != null) {
      selectedDistrito = distrito;
      print(
          "Distrito seleccionado: ${selectedDistrito!.id} - ${selectedDistrito!.name}");
    } else {
      print("Distrito no seleccionado");
      _showError(
          context, "Distrito no encontrado. Selecciona un distrito válido.");
    }
  }

  Future<void> login(BuildContext context) async {
    try {
      if (_areFieldsEmpty([emailController, passwordController])) {
        _showError(context, "Correo y contraseña son obligatorios");
        return;
      }

      final response = await usuarioService.iniciarSesion(
        emailController.text,
        passwordController.text,
      );

      if (response?.status == 200) {
        final body = response!.body;
        if (body['success'] == true) {
          print("Respuesta completa del servidor: ${body['data']}");

          // Guardar el token en el SesionController
          final token = body['token'];
          await sesion.guardarToken(token); // Guardar el token de autenticación

          _showSuccess(context, body['message'] ?? "Inicio de sesión exitoso");
          Navigator.of(context)
              .pushReplacementNamed('/home'); // Navegar al Home
        } else {
          _showError(
              context, body['message'] ?? "Correo o contraseña incorrectos");
        }
      } else {
        _showError(context, response?.body ?? "Error al iniciar sesión");
      }
    } catch (e) {
      _showError(context, "Error al iniciar sesión: $e");
    }
  }

  Future<void> handleAction(BuildContext context) async {
    if (isLogin.value) {
      await login(context);
    } else {
      await register(context);
    }
  }

  Future<void> register(BuildContext context) async {
    try {
      if (selectedDistrito == null) {
        _showError(context, "Por favor selecciona un distrito válido");
        return;
      }
      if (selectedSexoId.value == 0) {
        _showError(context, "Por favor selecciona un sexo");
        return;
      }

      final data = {
        "email": emailController.text,
        "password": passwordController.text,
        "first_name": nombresController.text,
        "last_name":
            "${apellidoPaternoController.text} ${apellidoMaternoController.text}",
        "dni": dniController.text,
        "phone_number": telefonoController.text,
        "district": selectedDistrito?.id ?? 0,
        "gender_id": selectedSexoId.value, // Convertir sexo a ID
      };

      final response = await usuarioService.registerUser(data);

      if (response?.status == 200) {
        // Verificar si el backend indicó éxito
        if (response?.body['success'] == true) {
          _showSuccess(
              context, response?.body['message']); // Mostrar mensaje de éxito
          limpiarCampos(); // Limpiar campos después del registro
          Navigator.of(context)
              .pushReplacementNamed('/login/inicio'); // Navegar al login
        } else {
          // Mostrar el mensaje de error del backend
          _showError(context, response?.body['message'] ?? "Error desconocido");
        }
      } else {
        // Mostrar mensaje de error en caso de fallo
        _showError(context, response?.body ?? "Error al registrar usuario");
      }
    } catch (e) {
      // Manejar errores de conexión u otros problemas
      _showError(context, "Error al registrar usuario: $e");
    }
  }

  bool _areFieldsEmpty(List<TextEditingController> controllers) {
    return controllers.any((controller) => controller.text.isEmpty);
  }

  void limpiarCampos() {
    for (var controller in [
      nombresController,
      passwordController,
      dniController,
      apellidoPaternoController,
      apellidoMaternoController,
      telefonoController,
      distritoController
    ]) {
      controller.clear();
    }
    selectedDistrito = null; // Limpiar el distrito seleccionado también
    selectedSexoId.value == 0; // Limpiar el sexo seleccionado
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
