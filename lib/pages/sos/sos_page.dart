import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sos_controller.dart'; // Asegúrate de importar el controlador
import '../../components/sos_info.dart';

class SOSPage extends StatelessWidget {
  final SOSController sosController = Get.put(SOSController()); // Instancia del controlador

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SAMU Section usando SurveyInfo
            GestureDetector(
              onTap: () => sosController.makePhoneCall('105'),
              child: const SosInfo(
                imageUrl: 'assets/img_app/samu.png', // Reemplaza con la ruta correcta
                title: '🚑 Atención Médica Móvil (SAMU)',
              ),
            ),
            SizedBox(height: 20),
            // PNP Section usando SurveyInfo
            GestureDetector(
              onTap: () => sosController.makePhoneCall('113'),
              child: const SosInfo(
                imageUrl: 'assets/img_app/PNP.png', // Reemplaza con la ruta correcta
                title: '🚓 Policía Nacional del Perú (PNP)',
              ),
            ),
            SizedBox(height: 20),
            // Bomberos Section usando SurveyInfo
            GestureDetector(
              onTap: () => sosController.makePhoneCall('116'),
              child: const SosInfo(
                imageUrl: 'assets/img_app/bomberos.png', // Reemplaza con la ruta correcta
                title: '👨‍🚒 Bomberos Voluntarios del Perú',
              ),
            ),
            SizedBox(height: 20),
            // Serenazgo Section usando SurveyInfo
            GestureDetector(
              onTap: () => sosController.makePhoneCall('104'),
              child: const SosInfo(
                imageUrl: 'assets/img_app/serenazgo.png', // Reemplaza con la ruta correcta
                title: '👮 Central de Serenazgo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
