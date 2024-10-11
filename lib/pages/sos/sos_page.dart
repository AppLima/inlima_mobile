import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sos_controller.dart'; // Ensure you import the controller

class SOSPage extends StatelessWidget {
  final SOSController sosController = Get.put(SOSController()); // Instantiate the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView( // Add scrollable functionality
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SAMU Section
            _buildSOSSection(
              imagePath: 'assets/img_app/samu.png', // Replace with the correct path
              label: '🚑 Atención Médica Móvil (SAMU)',
              phoneNumber: '105',
            ),
            SizedBox(height: 20),
            // PNP Section
            _buildSOSSection(
              imagePath: 'assets/img_app/PNP.png', // Replace with the correct path
              label: '🚓 Policía Nacional del Perú (PNP)',
              phoneNumber: '113',
            ),
            SizedBox(height: 20),
            // Bomberos Section
            _buildSOSSection(
              imagePath: 'assets/img_app/bomberos.png', // Replace with the correct path
              label: '👨‍🚒 Bomberos Voluntarios del Perú',
              phoneNumber: '116',
            ),
            SizedBox(height: 20),
            // Serenazgo Section
            _buildSOSSection(
              imagePath: 'assets/img_app/serenazgo.png', // Replace with the correct path
              label: '👮 Central de Serenazgo',
              phoneNumber: '104',
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build an SOS section with image above the button
  Widget _buildSOSSection({
    required String imagePath,
    required String label,
    required String phoneNumber,
  }) {
    return Column(
      children: [
        // Image container
        Image.asset(
          imagePath,
          height: 100, // Set a fixed height for the image
          fit: BoxFit.contain, // Maintain aspect ratio
        ),
        SizedBox(height: 10),
        // Button container
        ElevatedButton(
          onPressed: () => sosController.makePhoneCall(phoneNumber),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16, // You can adjust the font size
            ),
          ),
        ),
      ],
    );
  }
}
