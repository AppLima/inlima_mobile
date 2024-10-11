import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'result_controller.dart';
import '../../components/Result_card.dart';
import '../../components/inlima_appbar.dart';
import '../../components/lateral_bar.dart';

class ResultPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildBody(BuildContext context) {
    final ResultController control = Get.put(
      ResultController(
        ModalRoute.of(context)?.settings.arguments as List<String> ?? []
      )
    );

    control.resetData();
    control.topics.assignAll(ModalRoute.of(context)?.settings.arguments as List<String> ?? []);
    control.listComplaints();

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
      key: _scaffoldKey, // Pass the key to Scaffold
      appBar: InLimaAppBar(
        isInPerfil: false,
        scaffoldKey: _scaffoldKey, // Pass the scaffoldKey to the InLimaAppBar
      ),
      drawer: LateralBar(),
      resizeToAvoidBottomInset: false,
      body: _buildBody(context),
    );
  }
}
