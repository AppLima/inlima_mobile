import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/pages/login/inicio/inicio_page.dart';

class PaginaPrincipalController extends GetxController {
  // Método para manejar la navegación con retraso
  void navigateToHome(BuildContext context) {
    // Navegación a la página de login
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            InicioPage(), // Redirige a la página de login o al register dependiendo de la condicionmn
      ),
    );
  }
}
