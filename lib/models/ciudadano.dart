class Ciudadano {
  final int id;
  final String dni;
  final String phoneNumber;
  final int userId;
  final int districtId;

  Ciudadano({
    required this.id,
    required this.dni,
    required this.phoneNumber,
    required this.userId,
    required this.districtId,
  });

  factory Ciudadano.fromMap(Map<String, dynamic> map) {
    return Ciudadano(
      id: map['id'] ?? 0,
      dni: map['dni'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      userId: map['user_id'] ?? 0,
      districtId: map['district_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dni': dni,
      'phone_number': phoneNumber,
      'user_id': userId,
      'district_id': districtId,
    };
  }
}
