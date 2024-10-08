import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart';
import 'package:inlima_mobile/components/survey_info.dart';
import 'package:inlima_mobile/models/sondeo.dart';
import 'survey_controller.dart';

class SurveyPage extends StatelessWidget {
  final SurveyController control = Get.put(SurveyController());
  final SesionController sesion= Get.find<SesionController>();

  SurveyPage({super.key});

  Widget _buildBody(BuildContext context) {
    return Obx(() {
      if (control.sondeosDisponibles.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      /* Verificar si hay sondeos disponibles
        if (control.sondeosDisponibles.isEmpty) {
          return const Center(child: Text('No hay sondeos disponibles'));
        }
      */

      // Lista de sondeos disponibles
      return ListView.builder(
        itemCount: control.sondeosDisponibles.length,
        itemBuilder: (context, index) {
          Sondeo sondeo = control.sondeosDisponibles[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/survey_description', arguments: sondeo);
            },
            child: SurveyInfo(
              imageUrl: sondeo.foto,
              title: sondeo.titulo,
              date: sondeo.fechaInicio.year.toString(),
            ),
          );
        },
      );
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Sondeos disponibles')),
    body: _buildBody(context),
    floatingActionButton: Obx(() {
      if (sesion.usuario.rolId == 1) {
        return FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/survey_creation');
          },
          child: const Icon(Icons.add),
        );
      }
      return const SizedBox.shrink();
    }),
  );
}
}
