import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/components/large_button.dart';
import 'package:inlima_mobile/components/tab.dart';
import 'package:inlima_mobile/configs/colors.dart';
import 'inicio_controller.dart';

class InicioPage extends StatelessWidget {
  final InicioController control = Get.put(InicioController());
  final bool isRegister;

  InicioPage({required this.isRegister}) {
    control.isLogin.value = !isRegister;
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
              decoration: BoxDecoration(
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
                    SizedBox(height: 10),
                    Image.asset(
                      'assets/login/inlima.png',
                      height: 40,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Tabs(), // Usamos el TabsComponent aquí
                        SizedBox(height: 20),
                        Obx(() => Text(
                              control.getWelcomeText(),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        SizedBox(height: 20),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Correo',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          obscureText: true,
                        ),
                        Obx(() => Column(
                              children: control.getAdditionalFields(),
                            )),
                        SizedBox(height: 30),
                        Obx(() => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: LargeButton(
                                title: control.getButtonText(),
                                onPressed: () {
                                  control.handleAction();
                                },
                                backgroundColor:
                                    AppColors.primaryColorInlima,
                                borderRadius: BorderRadius.circular(30),
                                textColor: Colors.white,
                                height: 50.0,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }
}
