import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/components/customprofilepicture.dart';
import 'package:inlima_mobile/components/customtextfield.dart';
import 'package:inlima_mobile/components/customdropdownfield.dart';
import 'package:inlima_mobile/components/inlima_appbar.dart';
import 'package:inlima_mobile/components/large_button.dart';
import 'package:inlima_mobile/configs/colors.dart';
import 'package:inlima_mobile/pages/perfil/perfil_controller.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final PerfilController perfilController = Get.put(PerfilController());

  // Agregamos el scaffoldKey
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    perfilController
        .autoRellenarCampos(); // Llama a la lógica de autocompletado en el controlador
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Asignamos la clave al Scaffold
      resizeToAvoidBottomInset: false,
      appBar: InLimaAppBar(
        isInPerfil: true, // Indicamos que el perfil es true
        scaffoldKey: _scaffoldKey, // Pasamos el scaffoldKey al AppBar
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 30,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          right: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Center(
              child: Text(
                'AJUSTE DE PERFIL',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.textColorWhite
                      : AppColors.primaryColorInlima,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Obx(() {
              return CustomProfilePicture(
                imageFile: perfilController.imageFile.value,
                onCameraPressed: () {
                  perfilController.seleccionarImagen(true);
                },
                onGalleryPressed: () {
                  perfilController.seleccionarImagen(false);
                },
              );
            }),
            const SizedBox(height: 30),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                CustomTextField(
                  labelText: 'Correo',
                  inputType: TextInputType.emailAddress,
                  controller: perfilController.emailController,
                  icon: Icons.email_outlined,
                ),
                CustomTextField(
                  labelText: 'Contraseña',
                  inputType: TextInputType.text,
                  controller: perfilController.passwordController,
                  obscureText: true,
                  icon: Icons.lock_outline,
                ),
                CustomTextField(
                  labelText: 'DNI',
                  inputType: TextInputType.number,
                  controller: perfilController.dniController,
                  icon: Icons.badge_outlined,
                ),
                CustomTextField(
                  labelText: 'Nombre',
                  inputType: TextInputType.text,
                  controller: perfilController.nombreController,
                  icon: Icons.person_outline,
                ),
                CustomTextField(
                  labelText: 'Apellido Paterno',
                  inputType: TextInputType.text,
                  controller: perfilController.apellidoPaternoController,
                  icon: Icons.person_outline,
                ),
                CustomTextField(
                  labelText: 'Apellido Materno',
                  inputType: TextInputType.text,
                  controller: perfilController.apellidoMaternoController,
                  icon: Icons.person_outline,
                ),
                Obx(() {
                  return CustomDropdownField(
                    labelText: 'Distrito',
                    selectedValue: perfilController.selectedDistrito.value,
                    items: perfilController.distritos,
                    onChanged: perfilController.onDistritoChanged,
                    icon: Icons.location_on_outlined,
                  );
                }),
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Sexo:"),
                      RadioListTile<String>(
                        title: const Text("Masculino"),
                        value: "masculino",
                        groupValue: perfilController.selectedSexo.value,
                        onChanged: perfilController.onSexoChanged,
                      ),
                      RadioListTile<String>(
                        title: const Text("Femenino"),
                        value: "femenino",
                        groupValue: perfilController.selectedSexo.value,
                        onChanged: perfilController.onSexoChanged,
                      ),
                    ],
                  );
                }),
                Center(
                  child: GestureDetector(
                    onTap: perfilController.openCamera,
                    child: Image.asset(
                      Theme.of(context).brightness == Brightness.dark
                          ? 'assets/faceid_white.png'
                          : 'assets/faceid_negro.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: LargeButton(
                title: 'Actualizar',
                onPressed: () {
                  perfilController
                      .updateProfile(context); // Pasamos el BuildContext actual
                },
                backgroundColor: AppColors.secondaryColorInlima,
                textColor: Colors.white,
                borderRadius: BorderRadius.circular(30),
                height: 50.0, //test
              ),
            ),
          ],
        ),
      ),
    );
  }
}
