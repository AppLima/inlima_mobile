import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart';
import 'package:inlima_mobile/components/advise_card.dart';
import 'package:inlima_mobile/models/respuesta.dart';
import 'package:inlima_mobile/models/sondeo.dart';
import 'package:inlima_mobile/pages/survey_description/survey_description_controller.dart';
import 'package:inlima_mobile/components/inlima_appbar.dart';
import '../../components/lateral_bar.dart';
import 'package:fl_chart/fl_chart.dart';

class SurveyDescription extends StatelessWidget {
  final SurveyDescriptionController control =
      Get.put(SurveyDescriptionController());
  final SesionController sesion = Get.find<SesionController>();
  SurveyDescription({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                if (sesion.usuario?.rolId == 2) ...[
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
                        onPressed: () async {
                          // Crear objeto Respuesta para "Desacuerdo"
                          final respuesta = Respuesta(
                            idRespuesta: 0,
                            nombre: "Desacuerdo",
                            opcion: false,
                            idCiudadano: sesion.usuario?.id ?? 0,
                            idSondeo: sondeo.idSondeo,
                          );

                          // Llamar a enviarRespuesta
                          await control.enviarRespuesta(respuesta);

                          // Mostrar mensaje de éxito
                          Advise(
                            content:
                                "Se envió el sondeo correctamente. Gracias por tu contribución!",
                            previousPage: false,
                            route: "/home",
                          ).show(context);
                          print('Desacuerdo enviado');
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
                        onPressed: () async {
                          final respuesta = Respuesta(
                            idRespuesta: 0,
                            nombre: "De acuerdo",
                            opcion: true,
                            idCiudadano: sesion.usuario?.id ?? 0,
                            idSondeo: sondeo.idSondeo,
                          );

                          await control.enviarRespuesta(respuesta);

                          Advise(
                            content:
                                "Se envió el sondeo correctamente. Gracias por tu contribución!",
                            previousPage: false,
                            route: "/home",
                          ).show(context);
                          print('De acuerdo enviado');
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
                ] else ...[
                  const Text(
                    'Estadísticas del sondeo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Total respuestas: ${sondeo.positives + sondeo.negatives}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // PieChart
                  SizedBox(
                    height: 200, // Altura del gráfico
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        centerSpaceRadius: 40,
                        sections: [
                          PieChartSectionData(
                            value: sondeo.positives.toDouble(),
                            title: "Sí (${sondeo.positives})",
                            color: Colors.green,
                            radius: 60,
                            titleStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            value: sondeo.negatives.toDouble(),
                            title: "No (${sondeo.negatives})",
                            color: Colors.red,
                            radius: 60,
                            titleStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
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
        key: _scaffoldKey,
        appBar: InLimaAppBar(
          isInPerfil: true,
          scaffoldKey: _scaffoldKey,
        ),
        drawer: LateralBar(),
        body: _buildBody(context, sondeo));
  }
}
