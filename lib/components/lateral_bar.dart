import 'package:flutter/material.dart';
import 'package:inlima_mobile/configs/colors.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../pages/perfil/perfil_controller.dart';

class HomePageWithLateralBar extends StatefulWidget {
  @override
  _HomePageWithLateralBarState createState() => _HomePageWithLateralBarState();
}

class _HomePageWithLateralBarState extends State<HomePageWithLateralBar> {
  bool isLateralBarVisible = false;

  // Function to toggle the visibility of the lateral bar
  void toggleLateralBar() {
    setState(() {
      isLateralBarVisible = !isLateralBarVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          // Main content of the home page
          Center(
            child: Text('This is the main content of the home page.'),
          ),

          // Bottom navigation bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),

          // The lateral bar, positioned above the rest
          if (isLateralBarVisible)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 250,
              child: LateralBar(
                toggleLateralBar: toggleLateralBar, // Allow closing the bar
              ),
            ),
        ],
      ),
    );
  }
}

class LateralBar extends StatelessWidget {
  final VoidCallback toggleLateralBar;
  final Color buttonColor;
  final Color buttonTextColor;
  final PerfilController perfilController = Get.put(PerfilController());

  LateralBar({
    required this.toggleLateralBar,
    this.buttonColor = Colors.white, // Default button color
    this.buttonTextColor = Colors.black, // Default button text color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // The dark blue background
      child: Column(
        children: [
          const SizedBox(height: 50), // Spacing
          Obx(() => CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            backgroundImage: perfilController.imageFile.value != null
                ? FileImage(perfilController.imageFile.value!)
                : null,
            child: perfilController.imageFile.value == null
                ? Icon(Icons.person, size: 50, color: Colors.white)
                : null,
          )),
          const SizedBox(height: 20),
          const Text(
            'User Name',
            style: TextStyle(color: AppColors.primaryColorInlima, fontSize: 18),
          ),
          const SizedBox(height: 20),

          // Button to add or update profile picture
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor, // Custom button color
            ),
            onPressed: () => _showImagePicker(context),
            icon: Icon(Icons.camera_alt, color: buttonTextColor), // Icon for image update
            label: Text(
              'Añadir o actualizar rostro',
              style: TextStyle(color: buttonTextColor), // Custom text color
            ),
          ),
          const SizedBox(height: 10),

          // Terms and conditions button
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor, // Custom button color
            ),
            onPressed: () => _showTermsAndConditions(context),
            icon: Icon(Icons.description, color: buttonTextColor), // Icon for terms and conditions
            label: Text(
              'Términos y condiciones',
              style: TextStyle(color: buttonTextColor), // Custom text color
            ),
          ),
          const SizedBox(height: 10),

          // Notification permission toggle button
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor, // Custom button color
            ),
            onPressed: () async {
              PermissionStatus status = await Permission.notification.status;
              if (!status.isGranted) {
                status = await Permission.notification.request();
              }

              if (status.isGranted) {
                Get.snackbar('Permisos de Notificación', 'Notificaciones activadas');
              } else if (status.isPermanentlyDenied) {
                Get.snackbar('Permisos de Notificación', 'Permisos de notificaciones denegados permanentemente. Actívelos manualmente.');
                openAppSettings();
              } else {
                Get.snackbar('Permisos de Notificación', 'Notificaciones no activadas');
              }
            },
            icon: Icon(Icons.notifications, color: buttonTextColor), // Icon for notifications
            label: Text(
              'Notificaciones',
              style: TextStyle(color: buttonTextColor), // Custom text color
            ),
          ),
          const SizedBox(height: 10),

          // Log out button
          const Spacer(), // Pushes the button to the bottom
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor, // Custom button color
            ),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.settings.name == '/login'); // Navigates to login page
            },
            icon: Icon(Icons.logout, color: buttonTextColor), // Icon for log out
            label: Text(
              'Cerrar Sesión',
              style: TextStyle(color: buttonTextColor), // Custom text color
            ),
          ),
        ],
      ),
    );
  }

  // Method to show a dialog for image selection
  void _showImagePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar Imagen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Cámara'),
                onTap: () {
                  perfilController.seleccionarImagenDesdeCamara();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_album),
                title: const Text('Galería'),
                onTap: () {
                  perfilController.seleccionarImagenDesdeGaleria();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to show terms and conditions in a dialog
  void _showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Términos y Condiciones'),
          content: SingleChildScrollView(
            child: const Text(
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
