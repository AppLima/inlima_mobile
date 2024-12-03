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
    idSondeo: map['id'] ?? 0, // Cambia 'id_sondeo' a 'id'
    titulo: map['title'] ?? '', // Cambia 'titulo' a 'title'
    descripcion: map['description'] ?? '', // Cambia 'descripcion' a 'description'
    foto: map['photo'] ?? '', // Cambia 'foto' a 'photo'
    cantidad: map['total_results'] ?? 0, // Cambia 'cantidad' a 'total_results'
    fechaInicio: map['start_date'] != null
        ? DateTime.parse(map['start_date'])
        : DateTime.now(), // Cambia 'fecha_inicio' a 'start_date'
    fechaFin: map['end_date'] != null
        ? DateTime.parse(map['end_date'])
        : DateTime.now(), // Cambia 'fecha_fin' a 'end_date'
    disponible: map['status'] ?? false, // Cambia 'disponible' a 'status'
    idMunicipalidad: map['district_id'] ?? 0, // Cambia 'id_municipalidad' a 'district_id'
  );
}


}
