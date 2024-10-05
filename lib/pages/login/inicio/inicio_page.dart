import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'inicio_controller.dart';

class InicioPage extends StatelessWidget {
  InicioController control = Get.put(InicioController());

  Widget _buildBody(BuildContext context){
    return SafeArea(child: Text('SECCION DE LOGIN-REGISTER'));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: _buildBody(context),
    ));
  }
}
