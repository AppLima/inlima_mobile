import 'package:flutter/material.dart';
import '../_global_controllers/sesion_controller.dart';
import 'package:get/get.dart';

class LateralBar extends StatelessWidget {
  const LateralBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SesionController sesionController = Get.find<SesionController>();

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.account_circle, size: 50, color: Colors.black),
                SizedBox(height: 10),
                Text(sesionController.usuario.nombre.isNotEmpty
                    ? sesionController.usuario.nombre
                    : "Usuario", style: TextStyle(fontSize: 20)), 
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Ajustes"),
                  onTap: () {
                    print("Ajustes");
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.article),
                  title: Text("Términos y Condiciones"),
                  onTap: () {
                    print("Términos y Condiciones");
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text("Notificaciones"),
                  onTap: () {
                    print("Notificaciones");
                    Navigator.pop(context); 
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
                sesionController.cerrarSesion();
                print("Sesión cerrada");


                Navigator.pushReplacementNamed(context, '/login/pagina_principal');
              },
              child: Text("Cerrar Sesión", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
