class Usuario {
  final int idUsuario;
  final String email;
  final String password;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String? foto;
  final int rolId;
  final int sexoId;

  Usuario({
    required this.idUsuario,
    required this.email,
    required this.password,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    this.foto,
    required this.rolId,
    required this.sexoId,
  });

  // Método para convertir un Usuario a un Map (toJson)
  Map<String, dynamic> toJson() {
    return {
      'id_usuario': idUsuario,
      'email': email,
      'password': password,
      'nombre': nombre,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
      'foto': foto,
      'rol_id': rolId,
      'sexo_id': sexoId,
    };
  }

  // Método para crear un Usuario desde un Map (fromMap)
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['id_usuario'],
      email: map['email'],
      password: map['password'],
      nombre: map['nombre'],
      apellidoPaterno: map['apellido_paterno'],
      apellidoMaterno: map['apellido_materno'],
      foto: map['foto'],
      rolId: map['rol_id'],
      sexoId: map['sexo_id'],
    );
  }

  // Método toString para representar la clase como String
  @override
  String toString() {
    return 'Usuario{idUsuario: $idUsuario, email: $email, nombre: $nombre, apellidoPaterno: $apellidoPaterno, apellidoMaterno: $apellidoMaterno, rolId: $rolId, sexoId: $sexoId}';
  }
}