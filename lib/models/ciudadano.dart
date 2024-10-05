class Ciudadano {
  final int id;
  final String dni;
  final String numero;
  final int usuarioId;

  Ciudadano({
    required this.id,
    required this.dni,
    required this.numero,
    required this.usuarioId,
  });

  // Método para convertir un Ciudadano a un Map (toJson)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dni': dni,
      'numero': numero,
      'usuario_id': usuarioId,
    };
  }

  // Método para crear un Ciudadano desde un Map (fromMap)
  factory Ciudadano.fromMap(Map<String, dynamic> map) {
    return Ciudadano(
      id: map['id'],
      dni: map['dni'],
      numero: map['numero'],
      usuarioId: map['usuario_id'],
    );
  }

  // Método toString para representar la clase como String
  @override
  String toString() {
    return 'Ciudadano{id: $id, dni: $dni, numero: $numero, usuarioId: $usuarioId}';
  }
}