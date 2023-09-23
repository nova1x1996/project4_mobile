// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:project_hk4_mobile/model/TypeDoctor.dart';

class Doctor {
  int id;
  String name;
  String username;
  String password;
  String email;
  String address;
  bool gender;
  DateTime? createAt;
  String? role;
  String? image;
  TypeDoctor typeDoctor;
  double? rating;

  Doctor({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.email,
    required this.address,
    required this.gender,
    required this.createAt,
    required this.role,
    required this.image,
    required this.typeDoctor,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'username': username,
      'password': password,
      'email': email,
      'address': address,
      'gender': gender,
      'createAt': createAt!.millisecondsSinceEpoch,
      'role': role,
      'image': image,
      'typeDoctor': typeDoctor.toMap(),
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map, double? rating) {
    return Doctor(
      id: map['id'] as int,
      name: map['name'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      gender: map['gender'] as bool,
      createAt:
          map['createAt'] != null ? DateTime.parse(map['createAt']) : null,
      role: map['role'] != null ? map['role'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      typeDoctor:
          TypeDoctor.fromMap(map['typeDoctorId'] as Map<String, dynamic>),
      rating: rating,
    );
  }

  String toJson() => json.encode(toMap());

  // factory Doctor.fromJson(String source) =>
  //     Doctor.fromMap(json.decode(source) as Map<String, dynamic>);
}
