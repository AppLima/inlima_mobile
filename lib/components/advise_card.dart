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
        content: Text(content),
        actions: <Widget>[
          TextButton(
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
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
