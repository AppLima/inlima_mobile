import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/models/usuario.dart';
import 'package:inlima_mobile/pages/home/home_controller.dart';

class HomePage extends StatelessWidget {
  final Usuario usuario;
  HomePage({super.key, required this.usuario});

  final HomeController home = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, ${usuario.nombre}'),
        leadingWidth: 70,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/img_app/inlima_logo_nobg.png',
            height: 20, 
            width: 20,   
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                home.navigateToSurvey(context);
              },
              child: const Text('Ir a Sondeos Disponibles'),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                home.navigateToComplaint(context);
              },
              child: const Text('Realizar una queja'),
            ),
          ),
        ],
      ),
    );
  }
}
