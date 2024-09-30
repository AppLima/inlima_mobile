import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:inlima_mobile/models/queja.dart';

class QuejaService {
  Future<List<Queja>> fetchAll() async {
    List<Queja> quejas = [];
    final String response =
        await rootBundle.loadString("assets/json/quejas.json");
    final List<dynamic> data = jsonDecode(response);
    quejas = data
        .map((map) => Queja.fromMap(map as Map<String, dynamic>))
        .toList();
    return quejas;
  }
}
