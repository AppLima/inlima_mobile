import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/circular_button_card.dart';
import './complaint_controller.dart';
import '../../components/inlima_appbar.dart';

class ComplaintPage extends StatelessWidget {
  final ComplaintController complaintController = Get.put(ComplaintController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InLimaAppBar(), // La barra superior personalizada
      body: Obx(() {
        // Observar los cambios en el estado de las quejas
        if (complaintController.complaints.isEmpty) {
          return const Center(child: CircularProgressIndicator()); // Mostrar un indicador de carga si no hay datos
        }

        return Padding(
          padding: const EdgeInsets.all(16.0), // Espaciado alrededor del GridView
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Mostrar 2 botones circulares por fila
              crossAxisSpacing: 16, // Espaciado horizontal
              mainAxisSpacing: 16, // Espaciado vertical
            ),
            itemCount: complaintController.complaints.length, // Total de quejas
            itemBuilder: (context, index) {
              final queja = complaintController.complaints[index]; // Acceder a cada queja
              return CircularButton(
                svgPath: queja.urlSvg, // Ruta del SVG
                topic: queja.name, // Nombre de la queja
              );
            },
          ),
        );
      }),
    );
  }
}
