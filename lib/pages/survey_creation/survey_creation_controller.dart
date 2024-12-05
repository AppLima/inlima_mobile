import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inlima_mobile/apis/survey_api.dart';

class SurveyCreationController extends GetxController {
  SurveyService sondeoService = SurveyService();
  final FirebaseStorage _storage = FirebaseStorage.instance;
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

    Future<String?> uploadImage(File imageFile) async {
    try {
      final String fileName = imageFile.path.split("/").last;
      Reference ref = _storage.ref().child('sondeos/$fileName');
      
      SettableMetadata metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );
      
      UploadTask uploadTask = ref.putFile(imageFile, metadata);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print("URL $downloadUrl");
      return downloadUrl;
    } catch (e) {
      print("Error al subir imagen: $e");
      return null;
    }
  }

  // Método para enviar el sondeo
void enviarSondeo(BuildContext context, Function? onSuccess) async {
  String titulo = tituloController.text;
  String detalle = detalleController.text;
  print("CREANDO SONDEO ===============================================");
  if (titulo.isEmpty || detalle.isEmpty || imagenSeleccionada.value == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Todos los campos son obligatorios")),
    );
    return;
  }

  try {
    // Subir la imagen a Firebase Storage
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Subiendo imagen...")),
    );
    String? imageUrl = await uploadImage(imagenSeleccionada.value!);

    if (imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al subir la imagen.")),
      );
      return;
    }

    // Crear el cuerpo del sondeo
    final data = {
      "title": titulo,
      "description": detalle,
      "photo": imageUrl, // URL de la imagen subida
      "start_date":  DateTime.now().toIso8601String() ,
      "end_date": DateTime.now().add(const Duration(days: 30)).toIso8601String()
    };

    // Llamar al servicio para enviar el sondeo
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Enviando sondeo...")),
    );
    final response = await sondeoService.createSurvey(data);
    print("RESPONSE $response");

    if (response != null && response.body != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sondeo creado exitosamente")),
      );

      // Limpiar los campos
      tituloController.clear();
      detalleController.clear();
      imagenSeleccionada.value = null;

      if (onSuccess != null) {
        onSuccess();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al crear el sondeo: ${response?.status}")),
      );
    }
  } catch (e) {
    print("Error en enviarSondeo: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ocurrió un error al crear el sondeo")),
    );
  }
  print("CREANDO SONDEO ===============================================");
}


  @override
  void onClose() {
    tituloController.dispose();
    detalleController.dispose();
    super.onClose();
  }
}
