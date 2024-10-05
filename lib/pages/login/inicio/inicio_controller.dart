import 'package:get/get.dart';
import 'package:flutter/material.dart';

class InicioController extends GetxController {
  RxBool isLogin = true.obs;
  void toggleTab() {
    isLogin.value = !isLogin.value;
  }

  String getWelcomeText() {
    return isLogin.value ? 'Bienvenido a inLima' : 'Regístrate en inLima';
  }

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

  void handleAction() {
    if (isLogin.value) {
      // Lógica de inicio de sesión
    } else {
      // Lógica de registro
    }
  }

  String getButtonText() {
    return isLogin.value ? 'Entrar' : 'Registrarse';
  }
}
