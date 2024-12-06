import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'historic_controller.dart';
import '../../components/historic_card.dart';
import '../../configs/colors.dart';

class HistoricPage extends StatelessWidget {
  HistoricPage({super.key});
  final HistoricController control = Get.put(HistoricController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        if (control.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (!control.isLoading.value && control.complaints.isEmpty) {
          return const Center(
            child: Text(
              "Aún no tienes quejas registradas en el historial",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          );
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.backgroundInlima,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Historial de Quejas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: _buildBody(context),
            )
          ],
        ),
      ),
    );
  }
}
