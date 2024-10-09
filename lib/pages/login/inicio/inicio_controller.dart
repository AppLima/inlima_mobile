import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart';
import 'package:inlima_mobile/models/ciudadano.dart';
import 'package:inlima_mobile/models/usuario.dart';
import 'package:inlima_mobile/services/usuario_service.dart';
import 'package:inlima_mobile/services/ciudadano_service.dart';
import 'dart:convert'; // Necesario para convertir a JSON

class InicioController {
  ValueNotifier<bool> isLogin = ValueNotifier(true);

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
  final SesionController sesion = Get.put(SesionController());  
  String getWelcomeText() {
    return isLogin.value ? 'Bienvenido a inLima' : 'Regístrate en inLima';
  }

  String getButtonText() {
    return isLogin.value ? 'Entrar' : 'Registrarse';
  }

  Future<void> handleAction(BuildContext context) async {
    if (isLogin.value) {
      await login(context);
    } else {
      await register(context);
    }
  }

  Future<void> login(BuildContext context) async {
    try {
      // Verifica si los campos están vacíos
      if (_areFieldsEmpty([emailController, passwordController])) {
        _showError(context, "Correo y contraseña son obligatorios");
        return;
      }

      // Busca el usuario por correo
      Usuario usuarioEncontrado =
          await usuarioService.findByEmail(emailController.text);

      // Si el usuario se encuentra, procede a verificar la contraseña (ejemplo básico)
      if (usuarioEncontrado != null &&
          usuarioEncontrado.password == passwordController.text) {
        // Actualiza el controlador de sesión con el usuario logueado
        sesion.iniciarSesion(usuarioEncontrado);
        _showSuccess(context, "Inicio de sesión exitoso");
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        _showError(context, "Correo o contraseña incorrectos");
      }
    } catch (e) {
      _showError(context, "Error al iniciar sesión: $e");
    }
  }

  Future<void> register(BuildContext context) async {
    try {
      if (!_validateFields(context)) return;

      // Validar email y DNI usando servicios
      if (await usuarioService.isEmailAlreadyRegistered(emailController.text)) {
        _showError(context, "El correo ya está registrado");
        return;
      }

      if (await ciudadanoService.isDniAlreadyRegistered(dniController.text)) {
        _showError(context, "El DNI ya está registrado");
        return;
      }

      // Crear usuario y ciudadano
      final usuario = Usuario(
        idUsuario: await usuarioService.getNewId(),
        email: emailController.text,
        password: passwordController.text,
        nombre: nombresController.text,
        apellidoPaterno: apellidoPaternoController.text,
        apellidoMaterno: apellidoMaternoController.text,
        rolId: 2,
        sexoId: 2,
      );

      final ciudadano = Ciudadano(
        id: await ciudadanoService.getNewId(),
        dni: dniController.text,
        numero: telefonoController.text,
        usuarioId: usuario.idUsuario,
      );

      // Guardar el usuario y ciudadano en sus respectivos servicios
      await usuarioService.addUsuario(usuario);
      await ciudadanoService.addCiudadano(ciudadano);

      // Mostrar éxito
      _showSuccess(context, "Registro exitoso");

      // Limpiar los campos después del registro
      limpiarCampos();
      isLogin.value = true;

      // Obtener y mostrar todos los usuarios
      List<Usuario> usuarios = await usuarioService.fetchAll();
      List<Ciudadano> ciudadanos = await ciudadanoService.fetchAll();

      print("Usuarios registrados:");
      for (var user in usuarios) {
        print(user
            .toJson()); // Aquí asumo que tienes un método toJson() o puedes personalizar cómo mostrar los datos
      }

      print("Ciudadanos registrados:");
      for (var citizen in ciudadanos) {
        print(
            citizen.toJson()); // Aquí también puedes personalizar la impresión
      }

      // Navegar a la página de inicio después del registro
      Navigator.of(context).pushReplacementNamed('/login/inicio');
    } catch (e) {
      _showError(context, "Error al registrar usuario: $e");
    }
  }

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
