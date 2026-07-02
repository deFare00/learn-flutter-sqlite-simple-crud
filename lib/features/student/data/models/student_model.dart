class StudentModel {
  final int? id;
  final String name;
  final int age;
  final String major;
  final String? phone;
  final String? email;
  final String? qrCode;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String createdAt;
  final String? updatedAt;

  const StudentModel({
    this.id,
    required this.name,
    required this.age,
    required this.major,
    this.phone,
    this.email,
    this.qrCode,
    this.latitude,
    this.longitude,
    this.address,
    required this.createdAt,
    this.updatedAt,
  });

  StudentModel copyWith({
    int? id,
    String? name,
    int? age,
    String? major,
    String? phone,
    String? email,
    String? qrCode,
    double? latitude,
    double? longitude,
    String? address,
    String? createdAt,
    String? updatedAt,
  }) {
    return StudentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      major: major ?? this.major,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      qrCode: qrCode ?? this.qrCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'age': age,
      'major': major,
      'phone': phone,
      'email': email,
      'qr_code': qrCode,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      age: map['age'] as int,
      major: map['major'] as String,
      phone: map['phone'] as String?,
      email: map['email'] as String?,
      qrCode: map['qr_code'] as String?,
      latitude: map['latitude'] as double?,
      longitude: map['longitude'] as double?,
      address: map['address'] as String?,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String?,
    );
  }

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}