import 'package:flutter/material.dart';

class Advise {
  final String content;
  final String? route;
  final bool previousPage;

  Advise({
    required this.content,
    this.route,
    this.previousPage = false,
  });

  void show(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Hacer las esquinas redondeadas
        ),
        backgroundColor: Colors.white, // Color de fondo del pop-up
        title: Row(
          children: const [
            Icon(Icons.info_outline, color: Colors.blue), // Ícono decorativo
            SizedBox(width: 8),
            Text(
              'Aviso',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Color del título
              ),
            ),
          ],
        ),
        content: Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54, // Color del contenido del texto
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue, // Color del botón
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Bordes redondeados para el botón
              ),
            ),
            onPressed: () {
              Navigator.pop(context, 'Aceptar'); // Cierra el diálogo
              
              // Redirigimos solo después de cerrar el diálogo
              if (route != null) {
                Navigator.pushNamed(context, route!); // Redirige si hay una ruta
              } else {
                // Si no hay ruta, redirigimos a '/login/pagina_principal'
                Navigator.pushReplacementNamed(context, '/login/pagina_principal');
              }

              if (previousPage) {
                Navigator.pop(context); // Vuelve a la página anterior si está habilitado
              }
            },
            child: const Text(
              'Aceptar',
              style: TextStyle(
                color: Colors.white, // Color del texto del botón
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
