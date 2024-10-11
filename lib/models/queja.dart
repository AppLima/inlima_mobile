import 'dart:convert';

class Queja {
  int id;
  String asunto;
  String descripcion;
  String ubicacion;
  String fecha;
  String estado;
  int usuarioId;
  List<String> fotos;

  Queja({
    required this.id,
    required this.asunto,
    required this.descripcion,
    required this.ubicacion,
    required this.fecha,
    required this.estado,
    required this.usuarioId,
    required this.fotos,
  });

  @override
  String toString() {
    return 'Queja{id: $id, asunto: $asunto, descripcion: $descripcion, ubicacion: $ubicacion, fecha: $fecha, estado: $estado, usuarioId: $usuarioId, fotos: $fotos}';
  }

  String toJSON() {
    final map = {
      'id': id,
      'asunto': asunto,
      'descripcion': descripcion,
      'ubicacion': ubicacion,
      'fecha': fecha,
      'estado': estado,
      'usuario_id': usuarioId,
      'foto': fotos,
    };
    return jsonEncode(map);
  }

  factory Queja.fromMap(Map<String, dynamic> map) {
    return Queja(
      id: map['id'] ?? 0,
      asunto: map['asunto'] ?? '',
      descripcion: map['descripcion'] ?? '',
      ubicacion: map['ubicacion'] ?? '',
      fecha: map['fecha'] ?? '',
      estado: map['estado'] ?? '',
      usuarioId: map['usuario_id'] ?? 0,
      fotos: List<String>.from(map['foto'] ?? []),
    );
  }
}