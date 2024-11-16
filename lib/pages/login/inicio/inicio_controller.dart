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
  ValueNotifier<String> selectedSexo =
      ValueNotifier(''); // Para manejar el sexo seleccionado

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
          "Distrito seleccionado: ${selectedDistrito!.id} - ${selectedDistrito!.nombre}");
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
          final usuario = Usuario.fromMap(body['data']);
          sesion.iniciarSesion(usuario);
          _showError(context, body['message'] ?? "Inicio de sesión exitoso");
          Navigator.of(context).pushReplacementNamed('/home');
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
      // Verificar que el distrito haya sido seleccionado
      // if (selectedDistrito == null) {
      //   _showError(context, "Por favor selecciona un distrito válido");
      //   return;
      // }

      // Verificar que el sexo haya sido seleccionado
      if (selectedSexo.value.isEmpty) {
        _showError(context, "Por favor selecciona un sexo");
        return;
      }

      // Crear el payload para el backend
      final data = {
        "email": emailController.text,
        "password": passwordController.text,
        "first_name": nombresController.text,
        "last_name":
            "${apellidoPaternoController.text} ${apellidoMaternoController.text}",
        "dni": dniController.text,
        "phone_number": telefonoController.text,
        "district": 1,
        "gender_id": 1, // Convertir sexo a ID
      };

      // Enviar los datos al backend
      final response = await usuarioService.registerUser(data);

      // Manejar la respuesta del backend
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

  // Future<void> register(BuildContext context) async {
  //   try {
  //     if (!_validateFields(context)) return;

  //     // Verificar que el distrito haya sido seleccionado
  //     if (selectedDistrito == null) {
  //       _showError(context, "Por favor selecciona un distrito válido");
  //       return;
  //     }

  //     // Verificar que el sexo haya sido seleccionado
  //     if (selectedSexo.value.isEmpty) {
  //       _showError(context, "Por favor selecciona un sexo");
  //       return;
  //     }

  //     // Validar email y DNI usando servicios
  //     if (await usuarioService.isEmailAlreadyRegistered(emailController.text)) {
  //       _showError(context, "El correo ya está registrado");
  //       return;
  //     }

  //     if (await ciudadanoService.isDniAlreadyRegistered(dniController.text)) {
  //       _showError(context, "El DNI ya está registrado");
  //       return;
  //     }

  //     print(
  //         "Distrito seleccionado para registro: ${selectedDistrito?.id} - ${selectedDistrito?.nombre}");

  //     // Crear usuario y ciudadano, incluyendo el distrito_id y sexo seleccionado
  //     final usuario = Usuario(
  //       idUsuario: await usuarioService.getNewId(),
  //       email: emailController.text,
  //       password: passwordController.text,
  //       nombre: nombresController.text,
  //       apellidos: apellidoPaternoController.text ++ apellidoMaternoController.text,
  //       rolId: 2,
  //       sexo: selectedSexo.value, // Guardamos el sexo seleccionado
  //       distritoId: selectedDistrito!
  //           .id, // Aseguramos que el distrito_id se asigna correctamente
  //     );

  //     final ciudadano = Ciudadano(
  //       id: await ciudadanoService.getNewId(),
  //       dni: dniController.text,
  //       numero: telefonoController.text,
  //       usuarioId: usuario.idUsuario,
  //     );

  //     // Guardar el usuario y ciudadano en sus respectivos servicios
  //     await usuarioService.addUsuario(usuario);
  //     await ciudadanoService.addCiudadano(ciudadano);

  //     _showSuccess(context, "Registro exitoso");

  //     // Limpiar los campos después del registro
  //     limpiarCampos();
  //     isLogin.value = true;

  //     // Obtener y mostrar todos los usuarios
  //     List<Usuario> usuarios = await usuarioService.fetchAll();
  //     List<Ciudadano> ciudadanos = await ciudadanoService.fetchAll();

  //     print("Usuarios registrados:");
  //     for (var user in usuarios) {
  //       print(user
  //           .toJson()); // Aquí asumo que tienes un método toJson() o puedes personalizar cómo mostrar los datos
  //     }

  //     print("Ciudadanos registrados:");
  //     for (var citizen in ciudadanos) {
  //       print(
  //           citizen.toJson()); // Aquí también puedes personalizar la impresión
  //     }
  //     Navigator.of(context).pushReplacementNamed('/login/inicio');
  //   } catch (e) {
  //     _showError(context, "Error al registrar usuario: $e");
  //   }
  // }

  bool _validateFields(BuildContext context) {
    final emailPattern =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    final phonePattern = RegExp(r"^9[0-9]{8}$");
    final dniPattern = RegExp(r"^[0-9]{8}$");
    final passwordPattern =
        RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$");

    if (_areFieldsEmpty([
      nombresController,
      apellidoPaternoController,
      apellidoMaternoController,
      dniController,
      emailController,
      passwordController,
      telefonoController
    ])) {
      _showError(context, "Todos los campos son obligatorios");
      return false;
    }

    if (!emailPattern.hasMatch(emailController.text)) {
      _showError(context, "Correo electrónico no válido");
      return false;
    }

    if (!phonePattern.hasMatch(telefonoController.text)) {
      _showError(context,
          "El número de teléfono debe tener 9 dígitos y comenzar con 9");
      return false;
    }

    if (!dniPattern.hasMatch(dniController.text)) {
      _showError(context, "El DNI debe tener 8 dígitos");
      return false;
    }

    if (!passwordPattern.hasMatch(passwordController.text)) {
      _showError(context,
          "La contraseña debe tener al menos 8 caracteres, una letra mayúscula, una letra minúscula y un número. No se permiten otros caracteres especiales");
      return false;
    }

    return true;
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
    selectedSexo.value = ''; // Limpiar el sexo seleccionado
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
