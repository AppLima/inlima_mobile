import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SurveyCreationController extends GetxController {
  final tituloController = TextEditingController();
  final detalleController = TextEditingController();
  var imagenSeleccionada = Rx<File?>(null); // Para almacenar la imagen seleccionada

  // Método para seleccionar una imagen
  Future<void> seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagen = await picker.pickImage(
        source: ImageSource.gallery);
    if (imagen != null) {
      imagenSeleccionada.value = File(imagen.path);
    }
  }

  // Método para enviar el sondeo
  void enviarSondeo(BuildContext context, Function? onSuccess) {
    String titulo = tituloController.text;
    String detalle = detalleController.text;

    if (titulo.isEmpty || detalle.isEmpty || imagenSeleccionada.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Todos los campos son obligatorios")));
    } else {
      print("===== SONDEO CREADO ========");
      print('Titulo: $titulo');
      print('Detalle: $detalle');
      print('Imagen seleccionada: ${imagenSeleccionada.value?.path}');
      print("============================");

      // Limpiar los campos después de enviar el sondeo
      tituloController.clear();
      detalleController.clear();
      imagenSeleccionada.value = null;
      if (onSuccess != null) {
        onSuccess();
      }
    }
  }

  @override
  void onClose() {
    tituloController.dispose();
    detalleController.dispose();
    super.onClose();
  }
}
