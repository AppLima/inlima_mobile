import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'historic_controller.dart';
import '../../components/historic_card.dart';

class HistoricPage extends StatelessWidget {
  final HistoricController control = Get.put(HistoricController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        if (control.complaints.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: control.complaints.length,
            itemBuilder: (context, index) {
              final queja = control.complaints[index];

              return HistoricCard(
                id: queja.id,
                asunto: queja.asunto,
                fecha: queja.fecha,
                ubicacion: queja.ubicacion,
                estado: queja.estado,
              );
            },
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Historial de Quejas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
        ),
        body: _buildBody(context),
      ),
    );
  }
}
