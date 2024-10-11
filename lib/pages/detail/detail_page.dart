import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'detail_controller.dart';
import '../../components/inlima_appbar.dart';

class DetailPage extends StatelessWidget {
  final DetailController control = Get.put(DetailController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text('Detail Page Content'),  // Contenido de la página
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const InLimaAppBar(isInPerfil: false), // Usa tu custom AppBar
      body: _buildBody(context),  // Cuerpo de la página
    );
  }
}
