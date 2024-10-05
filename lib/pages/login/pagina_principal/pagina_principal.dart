import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/components/large_button.dart';
import 'package:inlima_mobile/configs/colors.dart';
import 'package:inlima_mobile/pages/login/pagina_principal/pagina_principal_controller.dart';

class PaginaPrincipalPage extends StatelessWidget {
  final PaginaPrincipalController control =
      Get.put(PaginaPrincipalController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            color: AppColors.primaryColorInlima,
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login/fondo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/login/inlima_icon.png',
                      height: 100,
                    ),
                    SizedBox(height: 20),
                    Image.asset(
                      'assets/login/inlima.png',
                      height: 50,
                    ),
                  ],
                ),
              ),
              // Espacio expandido para empujar el contenido hacia abajo
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: LargeButton(
                  title: 'Comenzar',
                  borderRadius: BorderRadius.circular(100),
                  height: 50,
                  onPressed: () {
                    control.navigateToHome(context);
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('¿No tienes una cuenta? ',
                    style: TextStyle(color: Colors.white)),
                GestureDetector(
                  onTap: () {
                    control.navigateToHome(context);
                  },
                  child: Text(
                    'Regístrate',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 100), // Parecido al margin-bottom
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: null,
        body: _buildBody(context),
      ),
    );
  }
}
