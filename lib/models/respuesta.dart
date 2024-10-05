import 'dart:convert';

class Respuesta {
  int idRespuesta;
  String nombre;
  bool opcion;
  int idCiudadano;
  int idSondeo;

  Respuesta({
    required this.idRespuesta,
    required this.nombre,
    required this.opcion,
    required this.idCiudadano,
    required this.idSondeo,
  });

  // Método toJSON
  String toJSON() {
    final map = {
      'id_respuesta': idRespuesta,
      'nombre': nombre,
      'opcion': opcion,
      'id_ciudadano': idCiudadano,
      'id_sondeo': idSondeo,
    };
    return jsonEncode(map);
  }

  // Método fromMap
  factory Respuesta.fromMap(Map<String, dynamic> map) {
    return Respuesta(
      idRespuesta: map['id_respuesta'] as int,
      nombre: map['nombre'] as String,
      opcion: map['opcion'] == 1 ? true : false,
      idCiudadano: map['id_ciudadano'] as int,
      idSondeo: map['id_sondeo'] as int,
    );
  }
}
