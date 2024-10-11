class Distrito {
  int id;
  String nombre;

  Distrito({
    required this.id,
    required this.nombre,
  });

  // Método para crear una instancia de Distrito a partir de un Map
  factory Distrito.fromMap(Map<String, dynamic> map) {
    return Distrito(
      id: map['id'] ?? 0,
      nombre: map['nombre'] ?? '',
    );
  }

  // Método para convertir una instancia de Distrito a un Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }

  // Método toString para imprimir la información de la instancia
  @override
  String toString() {
    return 'Distrito{id: $id, nombre: $nombre}';
  }
}