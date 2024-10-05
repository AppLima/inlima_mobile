import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/pages/login/inicio/inicio_page.dart';

class PaginaPrincipalController extends GetxController {
  // Método para manejar la navegación
  void navigateToHome(BuildContext context, {required bool isRegister}) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => InicioPage(
          isRegister: isRegister, // Pasamos si es para registrar o login
        ),
      ),
    );
  }
}
