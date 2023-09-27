import 'package:intl/intl.dart';

var formatterDungGioDB = DateFormat('HH:mm:ss dd/MM/yyyy', 'en_US');

class Rating {
  final int id;
  final double rating;
  final String comment;
  final String createAt;
  final DoctorRating doctor;
  final PatientRating patient;

  Rating({
    required this.id,
    required this.rating,
    required this.comment,
    required this.createAt,
    required this.doctor,
    required this.patient,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'],
      rating: json['rating'],
      comment: json['comment'],
      createAt: json['createAt'],
      doctor: DoctorRating.fromJson(json['doctorId']),
      patient: PatientRating.fromJson(json['patientId']),
    );
  }
}

class DoctorRating {
  final int id;
  final String name;
  final String email;
  final String address;
  final bool gender;

  final String? image;

  DoctorRating({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.gender,
    required this.image,
  });

  factory DoctorRating.fromJson(Map<String, dynamic> json) {
    return DoctorRating(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      gender: json['gender'],
      image: json['image'] != null ? json['image'] : null,
    );
  }
}

class PatientRating {
  final int id;
  final String name;
  final String email;
  final String address;
  final String phone;

  final String? image;

  PatientRating({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.image,
  });

  factory PatientRating.fromJson(Map<String, dynamic> json) {
    return PatientRating(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      image: json['image'] != null ? json['image'] : null,
    );
  }
}
