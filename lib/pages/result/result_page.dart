import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'result_controller.dart';
import '../../components/Result_card.dart';
import '../../components/inlima_appbar.dart';

class ResultPage extends StatelessWidget {

  Widget _buildBody(BuildContext context) {
    final ResultController control = Get.put(
      ResultController(
        ModalRoute.of(context)?.settings.arguments as List<String> ?? []
      )
    );

    return SafeArea(
      child: Obx(() {
        if (control.complaints.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: control.complaints.length,
            itemBuilder: (context, index) {
              final queja = control.complaints[index];

              return ResultCard(
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
    return Scaffold(
      appBar: const InLimaAppBar(isInPerfil: false),
      resizeToAvoidBottomInset: false,
      body: _buildBody(context),
    );
  }
}
