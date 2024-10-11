import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/models/distrito.dart';
import 'package:inlima_mobile/services/distrito_service.dart';
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart';
import 'package:inlima_mobile/components/advise_card.dart';

class PerfilController extends GetxController {
  var imageFile = Rxn<File>(); // Usa Rxn para permitir valores nulos
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nombreController = TextEditingController();
  var apellidoPaternoController = TextEditingController();
  var apellidoMaternoController = TextEditingController();
  var dniController = TextEditingController();
  var distritoController = TextEditingController();

  final DistritoService distritoService = DistritoService();
  var selectedDistrito = Rxn<Distrito>(); // Distrito seleccionado
  var selectedSexo = ''.obs; // Sexo seleccionado

  List<Distrito> distritos = [];
  final SesionController sesionController = Get.put(SesionController());

  @override
  void onInit() {
    super.onInit();
    resetPerfilData();
    fetchDistritos(); // Cargar los distritos al iniciar
  }

  @override
  void dispose() {
    resetPerfilData();
    super.dispose();
  }

  // Método para autocompletar campos desde el usuario actual
  void autoRellenarCampos() async {
    final usuario = sesionController.usuario;
    final ciudadano = sesionController.ciudadano;

    if (usuario != null) {
      emailController.text = usuario.email;
      passwordController.text = usuario.password;
      nombreController.text = usuario.nombre;
      apellidoPaternoController.text = usuario.apellidoPaterno;
      apellidoMaternoController.text = usuario.apellidoMaterno;

      if (ciudadano != null) {
        dniController.text = ciudadano.dni;
      }

      if (distritos.isEmpty) {
        await fetchDistritos();
      }

      if (distritos.isNotEmpty) {
        selectedDistrito.value = distritos.firstWhere(
          (distrito) => distrito.id == usuario.distritoId,
          orElse: () => distritos.first,
        );
      }

      // Asegúrate de que el sexo tenga un valor válido
      if (usuario.sexo != null &&
          (usuario.sexo == "masculino" || usuario.sexo == "femenino")) {
        selectedSexo.value = usuario.sexo!;
      } else {
        // Asigna un valor predeterminado si no está definido o es incorrecto
        selectedSexo.value = "masculino";
      }
    }
  }

  // Método para cargar distritos desde el servicio
  Future<void> fetchDistritos() async {
    try {
      distritos = await distritoService.fetchAll();
    } catch (e) {
      print("Error al cargar distritos: $e");
    }
  }

  void onDistritoChanged(Distrito? distrito) {
    selectedDistrito.value = distrito;
  }

  void onSexoChanged(String? sexo) {
    selectedSexo.value = sexo ?? '';
  }

  // Método para seleccionar imagen desde la cámara o galería
  Future<void> seleccionarImagen(bool isCamera) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (pickedFile != null) {
      await _procesarImagen(File(pickedFile.path));
    }
  }

  Future<void> _procesarImagen(File image) async {
    imageFile.value = image;
  }

  void updateProfile(BuildContext context) {
    // Mostrar el mensaje de éxito
    Advise(
      content: 'Perfil actualizado correctamente',
      route: null, // No redirigimos automáticamente desde aquí
      previousPage: false,
    ).show(context);
  }

  void resetPerfilData() {
    imageFile.value = null;
    emailController.clear();
    passwordController.clear();
    nombreController.clear();
    apellidoPaternoController.clear();
    apellidoMaternoController.clear();
    dniController.clear();
    distritoController.clear();
    selectedDistrito.value = null;
    selectedSexo.value = '';
  }

  // Método para abrir la cámara
  void openCamera() {
    seleccionarImagen(true);
  }
}
