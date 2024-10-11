class Usuario {
  final int idUsuario;
  final String email;
  final String password;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String? foto;
  final int rolId;
  final String sexo; // Cambiamos sexoId a sexo, que será una cadena ("masculino", "femenino")
  final int distritoId; // Campo para almacenar el distrito

  Usuario({
    required this.idUsuario,
    required this.email,
    required this.password,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    this.foto,
    required this.rolId,
    required this.sexo, // Actualizamos para que acepte el sexo como cadena
    required this.distritoId, // Se añade al constructor
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
      'sexo': sexo, // Actualizamos el campo para reflejar el sexo como cadena
      'distrito_id': distritoId, // Se añade al JSON
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
      sexo: map['sexo'], // Actualizamos para recibir el sexo como cadena
      distritoId: map['distrito_id'], // Se añade al fromMap
    );
  }

  // Método toString para representar la clase como String
  @override
  String toString() {
    return 'Usuario{idUsuario: $idUsuario, email: $email, nombre: $nombre, apellidoPaterno: $apellidoPaterno, apellidoMaterno: $apellidoMaterno, rolId: $rolId, sexo: $sexo, distritoId: $distritoId}';
  }
}
