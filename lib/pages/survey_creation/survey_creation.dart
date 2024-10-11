import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/components/advise_card.dart';
import 'package:inlima_mobile/pages/survey_creation/survey_creation_controller.dart';
import 'package:inlima_mobile/components/inlima_appbar.dart';
import '../../components/lateral_bar.dart';

class SurveyCreationPage extends StatelessWidget {
  SurveyCreationPage({super.key});
  final SurveyCreationController control = Get.put(SurveyCreationController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      appBar: InLimaAppBar(
        isInPerfil: true,
        scaffoldKey: _scaffoldKey,
      ),
      drawer: LateralBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Título del sondeo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: control.tituloController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Detalle del sondeo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: control.detalleController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Adjunte foto del proyecto',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Obx(() => GestureDetector(
                      onTap: () {
                        control
                            .seleccionarImagen();
                      },
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(color: Colors.grey),
                          color: Colors.grey[200],
                        ),
                        child: control.imagenSeleccionada.value != null
                            ? Image.file(
                                control.imagenSeleccionada.value!,
                                fit: BoxFit.cover,
                              )
                            : const Center(
                                child: Icon(Icons.add_a_photo,
                                    size: 40, color: Colors.grey),
                              ),
                      ),
                    )),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    control.enviarSondeo(context, () {
                      Advise(
                              content: "Sondeo creado con éxito",
                              previousPage: true)
                          .show(context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Enviar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
