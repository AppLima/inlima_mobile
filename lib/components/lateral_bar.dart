import 'package:flutter/material.dart';
import 'package:inlima_mobile/configs/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import '../_global_controllers/sesion_controller.dart';
import 'package:get/get.dart';

class LateralBar extends StatelessWidget {
  const LateralBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SesionController sesionController = Get.find<SesionController>();

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.beigeColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.account_circle, size: 50, color: Colors.black),
                const SizedBox(height: 10),
                Text(
                    sesionController.usuario?.nombre.isNotEmpty == true
                        ? sesionController.usuario!.nombre
                        : "Usuario",
                    style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Ajustes"),
                    onTap: () {
                      print("ajustes");
                    }),
                ListTile(
                  leading: const Icon(Icons.article),
                  title: const Text("Términos y Condiciones"),
                  onTap: () {
                    _showTermsAndConditions(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text("Notificaciones"),
                  onTap: () async {
                    PermissionStatus status =
                        await Permission.notification.status;
                    if (!status.isGranted) {
                      status = await Permission.notification.request();
                    }
                    if (status.isGranted) {
                      Get.snackbar('Permisos de Notificación',
                          'Notificaciones activadas');
                    } else if (status.isPermanentlyDenied) {
                      Get.snackbar('Permisos de Notificación',
                          'Permisos de notificaciones denegados permanentemente. Actívelos manualmente.');
                      openAppSettings();
                    } else {
                      Get.snackbar('Permisos de Notificación',
                          'Notificaciones no activadas');
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                sesionController.borrarToken();
                print("Sesión cerrada");

                Navigator.pushReplacementNamed(
                    context, '/login/pagina_principal');
              },
              child: const Text("Cerrar Sesión",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // Method to show terms and conditions in a dialog
  void _showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Términos y Condiciones'),
          content: const SingleChildScrollView(
            child: Text(
              '''MIT License

Copyright (c) 2024 AppLima

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.''',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
