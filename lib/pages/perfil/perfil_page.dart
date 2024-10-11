import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/components/bottomnavigatorbar.dart';
import 'dart:io'; // Necesario para manejar archivos locales
import 'package:inlima_mobile/components/customtextfield.dart'; // Asegúrate de importar tu CustomTextField
import 'package:inlima_mobile/components/inlima_appbar.dart'; // Aquí haces referencia al InLimaAppBar
import 'package:inlima_mobile/components/large_button.dart'; // Importa tu LargeButton
import 'package:inlima_mobile/configs/colors.dart';
import 'package:inlima_mobile/pages/confi_biometrica/confi_biometrica_page.dart';
import 'package:inlima_mobile/pages/perfil/perfil_controller.dart'; // Importa tu PerfilController
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart'; // Importa tu SesionController
import '../../components/lateral_bar.dart';

class PerfilPage extends StatelessWidget {
  final PerfilController perfilController = Get.put(PerfilController());
  final SesionController sesionController = Get.put(SesionController()); // Instanciar el controlador de sesión
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Método que autorrellena los campos con los datos del usuario logueado
  void _autoRellenarCampos() {
    final usuario = sesionController.usuario; // Obtener el usuario logueado desde el getter 'usuario'

    if (usuario != null) {
      perfilController.emailController.text = usuario.email;
      perfilController.passwordController.text = usuario.password;
      perfilController.nombreController.text = usuario.nombre;
      perfilController.apellidoPaternoController.text = usuario.apellidoPaterno;
      perfilController.apellidoMaternoController.text = usuario.apellidoMaterno;
    }
  }

  Widget _buildBody(BuildContext context) {
    // Llenar los campos con los datos del usuario logueado
    _autoRellenarCampos();

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 30,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        right: 30,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'AJUSTE DE PERFIL',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30), // Espacio entre el título y los campos

            // Sección de la foto de perfil
            Center(
              child: Obx(() {
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                          child: perfilController.imageFile.value != null
                              ? ClipOval(
                                  child: Image.file(
                                    perfilController.imageFile.value!,
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  ),
                                )
                              : Image.asset(
                                  'assets/userDefault.png', // Imagen por defecto si no hay foto
                                  fit: BoxFit.contain,
                                ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 30,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt, color: Colors.black),
                            onPressed: () {
                              perfilController.seleccionarImagenDesdeCamara(); // Llama al método para la cámara
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 30,
                          child: IconButton(
                            icon: const Icon(Icons.upload, color: Colors.black),
                            onPressed: () {
                              perfilController.seleccionarImagenDesdeGaleria(); // Llama al método para la galería
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }),
            ),
            // Campos de texto
            CustomTextField(
              labelText: 'Correo',
              inputType: TextInputType.emailAddress,
              controller: perfilController.emailController,
            ),
            CustomTextField(
              labelText: 'Contraseña',
              inputType: TextInputType.text,
              controller: perfilController.passwordController,
              obscureText: true,
            ),
            CustomTextField(
              labelText: 'DNI',
              inputType: TextInputType.number,
              controller: perfilController.dniController,
            ),
            CustomTextField(
              labelText: 'Nombre',
              inputType: TextInputType.text,
              controller: perfilController.nombreController,
            ),
            CustomTextField(
              labelText: 'Apellido Paterno',
              inputType: TextInputType.text,
              controller: perfilController.apellidoPaternoController,
            ),
            CustomTextField(
              labelText: 'Apellido Materno',
              inputType: TextInputType.text,
              controller: perfilController.apellidoMaternoController,
            ),
            CustomTextField(
              labelText: 'Distrito actual',
              inputType: TextInputType.text,
              controller: perfilController.distritoController,
            ),
            // Botón Actualizar usando LargeButton
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LargeButton(
                    title: 'Configuración Biométrica',
                    onPressed: () {
                      Navigator.pushNamed(context, "/confi_biometrica");
                    },
                    backgroundColor: AppColors.textColorLightGray,
                    textColor: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    height: 50.0,
                    width: 150.0, // Ajusta el tamaño del botón si es necesario
                  ),
                  SizedBox(height: 20), // Espacio entre los dos botones
                  LargeButton(
                    title: 'Actualizar',
                    onPressed: () {
                      perfilController.actualizarPerfil();
                    },
                    backgroundColor: AppColors.secondaryColorInlima,
                    textColor: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    height: 50.0,
                    width: 200.0, // Ajusta el tamaño del botón si es necesario
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: InLimaAppBar(isInPerfil: true, scaffoldKey: _scaffoldKey),
      drawer: LateralBar(), // Aquí se pasa el parámetro isInPerfil
      body: _buildBody(context), // Todo el contenido está en _buildBody
    );
  }
}
