import 'package:flutter/material.dart';

class LateralBar extends StatelessWidget {
  //final Function(int) onItemTapped;
  //final int selectedIndex;

  const LateralBar({
    Key? key, // Texto del Drawer Header      // Tercer texto
    //required this.onItemTapped,  // Callback para gestionar el tap de opciones
    //required this.selectedIndex, // Índice seleccionado
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
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
                Text("Nombre", style: TextStyle(fontSize: 20)), // Texto del Header
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Ajustes"), // Primer ítem
            //selected: selectedIndex == 0,
            onTap: () {
              //onItemTapped(0); // Llamada a la función con índice 0
              print("Ajustes");
              Navigator.pop(context); // Cerrar Drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text("Ajustes"), // Segundo ítem
            //selected: selectedIndex == 1,
            onTap: () {
              print("Terminos y condiciones"); // Llamada a la función con índice 1
              Navigator.pop(context); // Cerrar Drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notificaciones"), // Tercer ítem
            //selected: selectedIndex == 2,
            onTap: () {
              //onItemTapped(2); // Llamada a la función con índice 2
              print("Notificaciones");
              Navigator.pop(context); // Cerrar Drawer
            },
          ),
        ],
      ),
    );
  }
}
