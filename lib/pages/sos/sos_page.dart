import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sos_controller.dart'; // Ensure you import the controller

class SOSPage extends StatelessWidget {
  final SOSController sosController = Get.put(SOSController()); // Instantiate the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SAMU Button with Image
            _buildSOSButton(
              iconPath: 'assets/img_app/samu.png', // Replace with the correct path
              label: '🚑 Atención Médica Móvil (SAMU)',
              phoneNumber: '105',
            ),
            SizedBox(height: 20),
            // PNP Button with Image
            _buildSOSButton(
              iconPath: 'assets/img_app/PNP.png', // Replace with the correct path
              label: '🚓 Policía Nacional del Perú (PNP)',
              phoneNumber: '113',
            ),
            SizedBox(height: 20),
            // Bomberos Button with Image
            _buildSOSButton(
              iconPath: 'assets/img_app/bomberos.png', // Replace with the correct path
              label: '👨‍🚒 Bomberos Voluntarios del Perú',
              phoneNumber: '116',
            ),
            SizedBox(height: 20),
            // Serenazgo Button with Image
            _buildSOSButton(
              iconPath: 'assets/img_app/serenazgo.png', // Replace with the correct path
              label: '👮 Central de Serenazgo',
              phoneNumber: '104',
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _buildSOSButton({required String iconPath, required String label, required String phoneNumber}) {
    return ElevatedButton(
      onPressed: () => sosController.makePhoneCall(phoneNumber),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            height: 40,
            width: 40,
            fit: BoxFit.cover, // Ensure the image fits well
          ),
          SizedBox(width: 10),
          Expanded( // Use Expanded to prevent overflow
            child: Text(
              label,
              overflow: TextOverflow.ellipsis, // Handle overflow
              style: TextStyle(
                fontSize: 16, // You can adjust the font size
              ),
            ),
          ),
        ],
      ),
    );
  }
}
