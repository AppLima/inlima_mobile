import 'package:flutter/material.dart';

class Advise {
  final String content;
  final String? route;

  Advise({
    required this.content,
    this.route,
  });

  void show(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(content),
        actions: <Widget>[
          /*
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancelar'),
          ),*/
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Continuar');
              if (route != null) {
                Navigator.pushNamed(context, route!);
              }
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
