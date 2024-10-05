import 'dart:convert';

import 'package:flutter/services.dart';
import '../models/sondeo.dart';

class SondeoService {
  Future<List<Sondeo>> fetchAll() async{
    List<Sondeo> sondeos = [];
    final String response = await rootBundle.loadString("assets/json/sondeos.json");
    final List<dynamic> data = jsonDecode(response);
    sondeos = data.map((map) => Sondeo.fromMap(map as Map <String, dynamic>)).toList();
    return sondeos;
  }
  // Función para obtener los sondeos disponibles
  Future<List<Sondeo>> fetchSondeosDisponibles() async {
    List<Sondeo> allSondeos = await fetchAll();
    List<Sondeo> availableSondeos = allSondeos.where((sondeo) => sondeo.disponible).toList();
    return availableSondeos;
  }
}