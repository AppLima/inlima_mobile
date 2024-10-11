import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dniController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoPaternoController = TextEditingController();
  final apellidoMaternoController = TextEditingController();
  final distritoController = TextEditingController();
  
  Rx<File?> imageFile = Rx<File?>(null); // Variable reactiva para almacenar la imagen seleccionada

  // Método para seleccionar imagen desde la cámara
  Future<void> seleccionarImagenDesdeCamara() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front, // Usa la cámara frontal
    );

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path); // Actualiza el archivo con la imagen seleccionada
    }
  }

  void resetData() {
      imageFile.value = null; // Resetea la imagen
      emailController.clear();
      passwordController.clear();
      nombreController.clear();
      apellidoPaternoController.clear();
      apellidoMaternoController.clear();
      dniController.clear();
      distritoController.clear();
  }
  // Método para seleccionar imagen desde la galería
  Future<void> seleccionarImagenDesdeGaleria() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery, // Acceder a la galería
    );

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path); // Actualiza el archivo con la imagen seleccionada
    }
  }

  void actualizarPerfil() {
    // Lógica para actualizar el perfil
  }
}
