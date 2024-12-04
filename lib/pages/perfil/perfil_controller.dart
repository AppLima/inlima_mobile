import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/models/distrito.dart';
import 'package:inlima_mobile/services/ciudadano_service.dart';
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
  RxBool isPasswordHidden = true.obs;
  final DistritoService distritoService = DistritoService();
  var selectedDistrito = Rxn<Distrito>(); // Distrito seleccionado
  var selectedGenero = 0.obs; // Género seleccionado como entero reactivo

  List<Distrito> distritos = [];
  final SesionController sesionController = Get.put(SesionController());

  @override
  void onInit() {
    super.onInit();
    resetPerfilData();
    fetchDistritos(); // Cargar los distritos al iniciar
    autoRellenarCampos(); // Autocompletar datos del perfil
  }

  @override
  void dispose() {
    resetPerfilData();
    super.dispose();
  }


  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
  // Método para autocompletar campos desde el usuario actual
  void autoRellenarCampos() async {
    // Cargar usuario y ciudadano desde el controlador de sesión
    final usuario = sesionController.usuario;
    final ciudadano = sesionController.ciudadano;

    if (usuario != null) {
      emailController.text = usuario.email;
      passwordController.text = usuario.password; 
      nombreController.text = usuario.nombre;
      apellidoPaternoController.text = usuario.apellido.split(' ')[0];
      apellidoMaternoController.text = usuario.apellido.split(' ').length > 1
          ? usuario.apellido.split(' ')[1]
          : '';
      selectedGenero.value = usuario.genderId ?? 0; // Asignar el género

      if (ciudadano != null) {
        dniController.text = ciudadano.dni;
      }

      // Cargar distritos
      if (distritos.isEmpty) {
        await fetchDistritos();
      }

      if (ciudadano != null && distritos.isNotEmpty) {
        final distritoEncontrado = distritos.firstWhere(
          (distrito) => distrito.id == ciudadano.districtId,
          orElse: () => Distrito(
              id: 0,
              name:
                  'No encontrado'), // Devuelve un distrito genérico si no encuentra.
        );

        selectedDistrito.value =
            distritoEncontrado.id != 0 ? distritoEncontrado : null;
      }
    } else {
      print("No hay usuario en sesión");
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

  // Método para cambiar el género
  void onGeneroChanged(int generoId) {
    selectedGenero.value = generoId;
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

  void updateProfile(BuildContext context) async {
    // Crear el mapa con los datos actualizados
    final CiudadanoService ciudadanoService = CiudadanoService();
    final data = {
      "user_id": sesionController.usuario!.id, // ID del usuario
      "email": emailController.text.trim(),
      "password": passwordController.text.isNotEmpty
          ? passwordController.text.trim()
          : null,
      "first_name": nombreController.text.trim(),
      "last_name":
          '${apellidoPaternoController.text.trim()} ${apellidoMaternoController.text.trim()}',
      "gender_id": selectedGenero.value,
      "dni": dniController.text.trim(),
      "phone_number": sesionController.ciudadano?.phoneNumber ?? '',
      "district": selectedDistrito.value?.id ?? 0,
    };

    try {
      // Llamar al método del servicio
      final response = await ciudadanoService.updateCiudadanoYUsuario(data);

      if (response['success'] == true) {
        Advise(
          content: 'Perfil actualizado correctamente',
          route: null,
          previousPage: false,
        ).show(context);
      } else {
        _showError(
              context, response['message']);
      }
    } catch (e) {
      _showError(context, "Error al registrar usuario: $e");
    }
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
    selectedGenero.value = 0;
  }

  // Método para abrir la cámara
  void openCamera() {
    seleccionarImagen(true);
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
