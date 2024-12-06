import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/components/historic_card.dart';
import 'package:inlima_mobile/components/result_card.dart';
import 'package:inlima_mobile/configs/colors.dart';
import 'package:inlima_mobile/pages/historic/historic_controller.dart';

class HistoricPage extends StatelessWidget {
  HistoricPage({super.key});
  final HistoricController control = Get.put(HistoricController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        if (control.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (!control.isLoading.value && control.complaints.isEmpty) {
          // Usar ListView vacío para habilitar el scroll y el refresh
          return ListView(
            children: const [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Aún no tienes quejas registradas en el historial",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          );
        } else {
          return ListView.builder(
            itemCount: control.complaints.length,
            itemBuilder: (context, index) {
              final queja = control.complaints[index];
              return ResultCard(
                id: queja.id,
                asunto: queja.asunto,
                descripcion: queja.descripcion,
                fecha: queja.fecha,
                ubicacion: queja.ubicacion,
                estado: queja.estado,
                fotos: queja.fotos,
                latitud: queja.latitud,
                longitud: queja.longitud,
                distrito: queja.distrito,
                usuarioId: queja.usuarioId,
              );
            },
          );
        }
      }),
    );
  }

  Future<void> _refreshComplaints() async {
    await control.listComplaints();
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
              child: RefreshIndicator(
                onRefresh: _refreshComplaints,
                child: _buildBody(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
