class Usuario {
  final int id; // Cambiado de idUsuario para coincidir con el JSON del backend
  final String email;
  final String password;
  final String nombre;
  final String apellido; // Combina apellidoPaterno y apellidoMaterno
  final String? foto; // Foto es opcional
  final int rolId;
  final int genderId; // gender_id es una cadena ("masculino", "femenino")// Distrito es opcional

  Usuario({
    required this.id,
    required this.email,
    required this.password,
    required this.nombre,
    required this.apellido,
    this.foto,
    required this.rolId,
    required this.genderId
  });

  // Método para convertir un Usuario a un Map (toJson)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'first_name': nombre,
      'last_name': apellido,
      'photo': foto,
      'role_id': rolId,
      'gender_id': genderId
    };
  }

  // Método para crear un Usuario desde un Map (fromMap)
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'] ?? 0, // Si falta, asigna 0
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      nombre: map['first_name'] ?? '',
      apellido: map['last_name'] ?? '',
      foto: map['photo'] != '' ? map['photo'] : null, // Convierte cadena vacía a null
      rolId: map['role_id'] ?? 0, // Si falta, asigna 0
      genderId: map['gender_id'] ?? 0, // Valor predeterminado si falta
    );
  }

  // Método toString para representar la clase como String
  @override
  String toString() {
    return 'Usuario{id: $id, email: $email, nombre: $nombre, apellido: $apellido, rolId: $rolId, gender_id: $genderId}';
  }
}
