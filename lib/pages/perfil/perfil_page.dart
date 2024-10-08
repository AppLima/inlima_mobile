import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/pages/perfil/Perfil_controller.dart';


class PerfilPage extends StatelessWidget {
  PerfilController control = Get.put(PerfilController());

  Widget _buildBody(BuildContext context){
    return SafeArea(child: Text('Templage Page'));
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
