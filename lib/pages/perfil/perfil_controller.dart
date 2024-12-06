import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
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
  var imageUrl = Rxn<String>(); // URL de la imagen guardada en Firebase
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  void autoRellenarCampos() async {
    final usuario = sesionController.usuario;

    if (usuario != null) {
      emailController.text = usuario.email;
      passwordController.text = usuario.password;
      nombreController.text = usuario.nombre;
      apellidoPaternoController.text = usuario.apellido.split(' ')[0];
      apellidoMaternoController.text = usuario.apellido.split(' ').length > 1
          ? usuario.apellido.split(' ')[1]
          : '';
      selectedGenero.value = usuario.genderId ?? 0;

      // Configurar imagen remota o local
      if (usuario.foto != null && usuario.foto!.isNotEmpty) {
        imageUrl.value = usuario.foto; // URL remota
        imageFile.value = null; // No hay archivo local
      } else {
        imageUrl.value = null; // Sin URL remota
        imageFile.value = null; // Sin archivo local
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

  Future<String?> uploadImage(File imageFile) async {
    try {
      final String fileName = imageFile.path.split("/").last;
      Reference ref = _storage.ref().child('usuarios/$fileName');

      SettableMetadata metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );

      UploadTask uploadTask = ref.putFile(imageFile, metadata);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error al subir imagen: $e");
      return null;
    }
  }

  Future<void> _procesarImagen(File image) async {
    imageFile.value = image;
    print("Imagen procesada: ${imageFile.value?.path}");
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // No permite cerrar el diálogo tocando fuera de él
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: const [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Actualizando perfil..."),
            ],
          ),
        );
      },
    );
  }

  Future<void> updateProfile(BuildContext context) async {
    final ciudadanoService = CiudadanoService();
    String? downloadUrl;

    _showLoadingDialog(context);

    try {
      if (imageFile.value != null) {
        downloadUrl = await uploadImage(imageFile.value!);
      }

      final data = {
        "user_id": sesionController.usuario!.id,
        "email": emailController.text.trim(),
        "password": passwordController.text.isNotEmpty
            ? passwordController.text.trim()
            : null,
        "first_name": nombreController.text.trim(),
        "last_name":
            '${apellidoPaternoController.text.trim()} ${apellidoMaternoController.text.trim()}',
        "gender_id": selectedGenero.value,
        "dni": dniController.text.trim(),
        "photo": downloadUrl ?? sesionController.usuario?.foto,
      };

      final response = await ciudadanoService.updateCiudadanoYUsuario(data);
      Navigator.of(context).pop();

      if (response['success'] == true) {
        Advise(content: 'Perfil actualizado correctamente', route: null)
            .show(context);
      } else {
        _showError(context, response['message']);
      }
    } catch (e) {
      Navigator.of(context).pop();
      _showError(context, "Error al actualizar perfil: $e");
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
