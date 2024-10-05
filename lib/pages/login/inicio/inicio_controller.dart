import 'package:get/get.dart';
import 'package:flutter/material.dart';

class InicioController extends GetxController {
  // Estado observable para manejar el login o registro
  RxBool isLogin = true.obs;

  // Método para cambiar entre login y registro
  void toggleTab() {
    isLogin.value = !isLogin.value;
  }

  // Método para obtener el título de bienvenida
  String getWelcomeText() {
    return isLogin.value ? 'Bienvenido a inLima' : 'Regístrate en inLima';
  }

  // Método para obtener los campos de texto adicionales si es registro
  List<Widget> getAdditionalFields() {
    if (isLogin.value) {
      return [];
    } else {
      return [
        SizedBox(height: 20),
        _buildTextField('DNI'),
        SizedBox(height: 20),
        _buildTextField('Nombres'),
        SizedBox(height: 20),
        _buildTextField('Apellido Paterno'),
        SizedBox(height: 20),
        _buildTextField('Apellido Materno'),
        SizedBox(height: 20),
        _buildTextField('Distrito Actual'),
      ];
    }
  }

  // Método para construir un campo de texto reutilizable
  Widget _buildTextField(String labelText) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // Método para manejar el botón de acción
  void handleAction() {
    if (isLogin.value) {
      // Lógica de inicio de sesión
    } else {
      // Lógica de registro
    }
  }

  // Método para obtener el texto del botón
  String getButtonText() {
    return isLogin.value ? 'Entrar' : 'Registrarse';
  }
}
