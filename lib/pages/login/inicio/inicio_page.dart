import 'package:flutter/material.dart';
import 'package:inlima_mobile/components/customdropdownfield.dart';
import 'package:inlima_mobile/components/customtextfield.dart';
import 'package:inlima_mobile/components/large_button.dart';
import 'package:inlima_mobile/components/tab.dart';
import 'package:inlima_mobile/configs/colors.dart';
import 'inicio_controller.dart';
import 'package:inlima_mobile/models/distrito.dart';

class InicioPage extends StatefulWidget {
  final bool isRegister;

  InicioPage({required this.isRegister});

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final InicioController control = InicioController();

  @override
  void initState() {
    super.initState();
    control.fetchDistritos(context); // Cargar los distritos al iniciar
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            color: AppColors.primaryColorInlima,
          ),
          Opacity(
            opacity: 0.4,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/login/fondo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/login/inlima_icon.png',
                      height: 80,
                    ),
                    const SizedBox(height: 10),
                    Image.asset(
                      'assets/login/inlima.png',
                      height: 40,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color.fromARGB(255, 24, 24, 24) // Color de fondo más oscuro para modo oscuro
                        : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        left: 30,
                        top: 20,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                        right: 30),
                    child: Column(
                      children: [
                        // Tabs para cambiar entre Login y Register
                        ValueListenableBuilder<bool>(
                          valueListenable: control.isLogin,
                          builder: (context, isLogin, child) {
                            return Tabs(
                              isLogin: isLogin,
                              onLoginTap: () {
                                control.isLogin.value = true;
                              },
                              onRegisterTap: () {
                                control.isLogin.value = false;
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        // Título del formulario
                        ValueListenableBuilder<bool>(
                          valueListenable: control.isLogin,
                          builder: (context, isLogin, child) {
                            return Text(
                              control.getWelcomeText(),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors
                                        .white // Cambiar a blanco en modo oscuro
                                    : Colors.black, // Color negro en modo claro
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),

                        // Aquí se modifica para usar Wrap y los CustomTextField con íconos
                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: [
                            CustomTextField(
                              labelText: 'Correo',
                              inputType: TextInputType.emailAddress,
                              controller: control.emailController,
                              icon: Icons.email_outlined, // Ícono agregado
                            ),
                            CustomTextField(
                              labelText: 'Contraseña',
                              inputType: TextInputType.text,
                              controller: control.passwordController,
                              obscureText: true,
                              icon: Icons.lock_outline, // Ícono agregado
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Si no es login, mostramos los campos adicionales
                        ValueListenableBuilder<bool>(
                          valueListenable: control.isLogin,
                          builder: (context, isLogin, child) {
                            if (!isLogin) {
                              return Wrap(
                                spacing: 20,
                                runSpacing: 20,
                                children: [
                                  CustomTextField(
                                    labelText: 'DNI',
                                    inputType: TextInputType.number,
                                    controller: control.dniController,
                                    icon:
                                        Icons.badge_outlined, // Ícono agregado
                                  ),
                                  CustomTextField(
                                    labelText: 'Nombres',
                                    inputType: TextInputType.text,
                                    controller: control.nombresController,
                                    icon:
                                        Icons.person_outline, // Ícono agregado
                                  ),
                                  CustomTextField(
                                    labelText: 'Apellido Paterno',
                                    inputType: TextInputType.text,
                                    controller:
                                        control.apellidoPaternoController,
                                    icon:
                                        Icons.person_outline, // Ícono agregado
                                  ),
                                  CustomTextField(
                                    labelText: 'Apellido Materno',
                                    inputType: TextInputType.text,
                                    controller:
                                        control.apellidoMaternoController,
                                    icon:
                                        Icons.person_outline, // Ícono agregado
                                  ),
                                  CustomTextField(
                                    labelText: 'Teléfono',
                                    inputType: TextInputType.phone,
                                    controller: control.telefonoController,
                                    icon:
                                        Icons.phone_outlined, // Ícono agregado
                                  ),
                                  // Dropdown para seleccionar el distrito
                                  CustomDropdownField(
                                    labelText: 'Distrito',
                                    selectedValue: control
                                        .selectedDistrito, // selectedDistrito debe ser de tipo Distrito
                                    items: control
                                        .distritos, // Esto espera una lista de tipo Distrito, pero lo manejamos con .map más abajo
                                    onChanged: (distrito) {
                                      setState(() {
                                        control.onDistritoChanged(context,
                                            distrito); // Actualiza el distrito seleccionado
                                      });
                                    },
                                    icon: Icons.location_on_outlined,
                                  ),
                                  // Nuevo RadioButtons para seleccionar sexo
                                  ValueListenableBuilder<String>(
                                    valueListenable: control.selectedSexo,
                                    builder: (context, selectedSexo, child) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Sexo:"),
                                          RadioListTile<String>(
                                            title: const Text("Masculino"),
                                            value: "masculino",
                                            groupValue: selectedSexo,
                                            onChanged: (value) {
                                              setState(() {
                                                control.selectedSexo.value =
                                                    value!;
                                              });
                                            },
                                          ),
                                          RadioListTile<String>(
                                            title: const Text("Femenino"),
                                            value: "femenino",
                                            groupValue: selectedSexo,
                                            onChanged: (value) {
                                              setState(() {
                                                control.selectedSexo.value =
                                                    value!;
                                              });
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),

                        const SizedBox(height: 30),
                        // Botón de acción
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: LargeButton(
                            title: control.getButtonText(),
                            onPressed: () {
                              control.handleAction(context);
                            },
                            backgroundColor: AppColors.primaryColorInlima,
                            borderRadius: BorderRadius.circular(30),
                            textColor: Colors.white,
                            height: 50.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(context),
    );
  }
}
