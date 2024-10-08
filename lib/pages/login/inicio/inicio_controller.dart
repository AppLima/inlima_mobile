import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart';
import 'package:inlima_mobile/models/ciudadano.dart';
import 'package:inlima_mobile/models/usuario.dart';
import 'package:inlima_mobile/services/usuario_service.dart';
import 'package:inlima_mobile/services/ciudadano_service.dart';

class InicioController {
  ValueNotifier<bool> isLogin = ValueNotifier(true);
  final SesionController sesion = Get.put(SesionController());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dniController = TextEditingController();
  final nombresController = TextEditingController();
  final apellidoPaternoController = TextEditingController();
  final apellidoMaternoController = TextEditingController();
  final telefonoController = TextEditingController();
  final distritoController = TextEditingController();
  final sexoController = TextEditingController();
  final UsuarioService usuarioService = UsuarioService();
  final CiudadanoService ciudadanoService = CiudadanoService();
  
  void toggleTab() {
    isLogin.value = !isLogin.value;
  }

  String getWelcomeText() {
    return isLogin.value ? 'Bienvenido a inLima' : 'Regístrate en inLima';
  }

  Future<void> handleAction(BuildContext context) async {
    if (isLogin.value) {
      await login(context);
    } else {
      await register(context);
    }
  }
  
  List<Widget> getAdditionalFields() {
    return [
      const SizedBox(height: 20),
      _buildTextField(dniController, 'DNI'),
      const SizedBox(height: 20),
      _buildTextField(nombresController, 'Nombres'),
      const SizedBox(height: 20),
      _buildTextField(apellidoPaternoController, 'Apellido Paterno'),
      const SizedBox(height: 20),
      _buildTextField(apellidoMaternoController, 'Apellido Materno'),
      const SizedBox(height: 20),
      _buildTextField(telefonoController, 'Teléfono'),
      const SizedBox(height: 20),
      _buildTextField(distritoController, 'Distrito Actual'),
    ];
  }

  String getButtonText() {
    return isLogin.value ? 'Entrar' : 'Registrarse';
  }

  Future<void> login(BuildContext context) async {
    try {
      if (_areFieldsEmpty([emailController, passwordController])) {
        _showError(context, "Correo y contraseña son obligatorios");
        return;
      }
      Usuario usuario = await usuarioService.findByEmail(emailController.text);
      if (usuario.password == passwordController.text) {
        Usuario usuarioEncontrado = usuario;
        sesion.iniciarSesion(usuario); //guarda usuario en global controller
        _showSuccess(context, "Inicio de sesión exitoso");
        Navigator.of(context).pushReplacementNamed('/home', arguments: usuarioEncontrado);
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
        sexoId: 1,
      );

      final ciudadano = Ciudadano(
        id: await ciudadanoService.getNewId(),
        dni: dniController.text,
        numero: telefonoController.text,
        usuarioId: usuario.idUsuario,
      );

      //await usuarioService.addUsuario(usuario);
      //await ciudadanoService.addCiudadano(ciudadano);
      print("========== Usuario registrado ============");
      print(usuario.toJson());
      _showSuccess(context, "Registro exitoso");
      limpiarCampos();
      isLogin.value = true;
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

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}