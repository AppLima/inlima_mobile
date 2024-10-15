import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sos_controller.dart'; 
import '../../components/sos_info.dart';

class SOSPage extends StatelessWidget {
  SOSPage({super.key});

  final SOSController sosController = Get.put(SOSController());

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
            GestureDetector(
              onTap: () => sosController.makePhoneCall('105'),
              child: const SosInfo(
                imageUrl: 'assets/img_app/samu.png',
                title: '🚑 Atención Médica Móvil (SAMU)',
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => sosController.makePhoneCall('113'),
              child: const SosInfo(
                imageUrl: 'assets/img_app/PNP.png',
                title: '🚓 Policía Nacional del Perú (PNP)',
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => sosController.makePhoneCall('116'),
              child: const SosInfo(
                imageUrl: 'assets/img_app/bomberos.png',
                title: '👨‍🚒 Bomberos Voluntarios del Perú',
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => sosController.makePhoneCall('104'),
              child: const SosInfo(
                imageUrl: 'assets/img_app/serenazgo.png',
                title: '👮 Central de Serenazgo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
