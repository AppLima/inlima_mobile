import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/components/advise_card.dart';
import 'package:inlima_mobile/models/sondeo.dart';
import 'package:inlima_mobile/pages/survey_description/survey_description_controller.dart';

class SurveyDescription extends StatelessWidget {
  final SurveyDescriptionController control =
      Get.put(SurveyDescriptionController());
  SurveyDescription({super.key});

  Widget _buildBody(BuildContext context, Sondeo sondeo) {
    final size =
        MediaQuery.of(context).size; // Para obtener el tamaño de la pantalla

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del proyecto
          SizedBox(
            width: size.width,
            height: size.height / 4,
            child: Image.network(
              sondeo.foto,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          // Contenido
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título del proyecto
                Text(
                  sondeo.titulo,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Fecha de disponibilidad
                Text(
                  'Disponible hasta ${sondeo.fechaFin.day}/${sondeo.fechaFin.month}/${sondeo.fechaFin.year}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Descripción del proyecto
                Text(
                  sondeo.descripcion,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                // Pregunta y botones de acuerdo/desacuerdo
                const Text(
                  '¿Está de acuerdo con que se realice el proyecto?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Botones de acción
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Acción para desacuerdo
                        Advise(
                                content:
                                    "Se envió el sondeo correctamente. Gracias por tu contribución!",
                                previousPage: true)
                            .show(context);
                        print('Desacuerdo');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                      child: const Text(
                        'Desacuerdo',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Advise(
                                content:
                                    "Se envió el sondeo correctamente. Gracias por tu contribución!",
                                previousPage: true)
                            .show(context);
                        print('De acuerdo');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                      child: const Text(
                        'De acuerdo',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Sondeo sondeo = ModalRoute.of(context)!.settings.arguments as Sondeo;
    return Scaffold(
        appBar: null,
        body: _buildBody(context, sondeo));
  }
}
