import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Patient {
  int id;
  String? username;
  String password;
  String name;
  String email;
  String address;
  String phone;
  String? role;
  String? image;
  Patient({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.role,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'password': password,
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'role': role,
      'image': image,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] as int,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      role: map['role'] != null ? map['role'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source) as Map<String, dynamic>);
}
