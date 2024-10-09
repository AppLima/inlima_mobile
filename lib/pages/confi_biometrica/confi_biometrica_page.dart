import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/pages/confi_biometrica/confi_biometrica_controller.dart';

class ConfiBiometricaPage extends StatelessWidget {
  final ConfiBiometricaController control = Get.put(ConfiBiometricaController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => Text(
                  '¿Se puede usar biometría?: ${control.canCheckBiometrics.value}',
                  style: TextStyle(fontSize: 18),
                )),
            const SizedBox(height: 10),
            Obx(() => Text(
                  'Tipos de biometría disponibles: ${control.availableBiometrics.map((e) => e.toString()).join(', ')}',
                  style: TextStyle(fontSize: 18),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: control.authenticate,
              child: Text('Autenticarse'),
            ),
            const SizedBox(height: 20),
            Obx(() => Text(
                  'Estado de autenticación: ${control.authorized.value}',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text('Configuración Biométrica')),
        body: _buildBody(context),
      ),
    );
  }
}
