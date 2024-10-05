import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/models/usuario.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  final Usuario usuario;

  HomePage({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, ${usuario.nombre}'),
      ),
      body: Center(
        child: Text('Has iniciado sesión como ${usuario.email}'),
      ),
    );
  }
}
