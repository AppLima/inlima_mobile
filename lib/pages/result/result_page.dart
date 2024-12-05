import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'result_controller.dart';
import '../../components/Result_card.dart';
import '../../components/inlima_appbar.dart';
import '../../components/lateral_bar.dart';

class ResultPage extends StatelessWidget {
  ResultPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildBody(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as List<Map<String, dynamic>>? ?? [];

    final ResultController control = Get.put(ResultController(arguments));
    control.resetData();
    control.topics.assignAll(arguments.map((e) => e['id'] as int).toList());
    control.topicNames.assignAll(arguments.map((e) => e['name'] as String).toList());
    control.listComplaints();
    
    return SafeArea(
      child: Obx(() {
        if (control.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (control.complaints.isEmpty) {
          return const Center(child: Text('No hay quejas disponibles.'));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Pass the key to Scaffold
      appBar: InLimaAppBar(
        isInPerfil: false,
        scaffoldKey: _scaffoldKey, // Pass the scaffoldKey to the InLimaAppBar
      ),
      drawer: const LateralBar(),
      resizeToAvoidBottomInset: false,
      body: _buildBody(context),
    );
  }
}
