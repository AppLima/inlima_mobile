import 'dart:convert';

class Sondeo {
  int idSondeo;
  String titulo;
  String descripcion;
  String foto;
  int cantidad;
  DateTime fechaInicio;
  DateTime fechaFin;
  bool disponible;
  int idMunicipalidad;

  Sondeo({
    required this.idSondeo,
    required this.titulo,
    required this.descripcion,
    required this.foto,
    required this.cantidad,
    required this.fechaInicio,
    required this.fechaFin,
    required this.disponible,
    required this.idMunicipalidad,
  });

  // Método toJSON
  String toJSON() {
    final map = {
      'id_sondeo': idSondeo,
      'titulo': titulo,
      'descripcion': descripcion,
      'foto': foto,
      'cantidad': cantidad,
      'fecha_inicio': fechaInicio.toIso8601String(),
      'fecha_fin': fechaFin.toIso8601String(),
      'disponible': disponible,
      'id_municipalidad': idMunicipalidad,
    };
    return jsonEncode(map);
  }

  // Método fromMap
  factory Sondeo.fromMap(Map<String, dynamic> map) {
    return Sondeo(
      idSondeo: map['id_sondeo'] as int,
      titulo: map['titulo'] as String,
      descripcion: map['descripcion'] as String,
      foto: map['foto'] as String,
      cantidad: map['cantidad'] as int,
      fechaInicio: DateTime.parse(map['fecha_inicio'] as String),
      fechaFin: DateTime.parse(map['fecha_fin'] as String),
      disponible: map['disponible'] as bool,
      idMunicipalidad: map['id_municipalidad'] as int,
    );
  }
}
