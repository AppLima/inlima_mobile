import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:inlima_mobile/apis/survey_api.dart';
import 'package:inlima_mobile/models/service_http_response.dart' as models;
import 'package:inlima_mobile/helpers/service_http_response.dart' as helpers;
import '../models/sondeo.dart';

class SondeoService {
  Future<List<Sondeo>> fetchAll() async {
    List<Sondeo> sondeos = [];
    final surveyService =
        SurveyService(); // Crea una instancia de SurveyService

    try {
      // Llama al método getSurveys() desde la instancia
      final models.ServiceHttpResponse? response = await surveyService.getSurveys();
      print("Survey fetchAll: $response");
      // Verifica que la respuesta no sea nula y tenga datos
      if (response != null && response.body != null && response.body is List) {
        print("RESPONSE BODY ${response.body}");
        sondeos = (response.body as List)
            .map((map) => Sondeo.fromMap(map as Map<String, dynamic>))
            .toList();
      } else {
        print("Error: La respuesta no contiene datos válidos.");
      }
    } catch (e) {
      print("Error en fetchAll: $e");
    }
    print("FETCH SONDEO ==============================================");
    for (var sondeo in sondeos) {
      var sondeoJSON = sondeo.toJSON();
      print("Sondeo: $sondeoJSON");
    }
    print("FETCH SONDEO ==============================================");
    return sondeos;
  }

  // Función para obtener los sondeos disponibles
  Future<List<Sondeo>> fetchSondeosDisponibles() async {
    List<Sondeo> allSondeos = await fetchAll();
    List<Sondeo> availableSondeos =
        allSondeos.where((sondeo) => sondeo.disponible).toList();
    return availableSondeos;
  }
}
