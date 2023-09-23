import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CheckLoginMobileDAO {
  String email;
  String password;
  CheckLoginMobileDAO({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory CheckLoginMobileDAO.fromMap(Map<String, dynamic> map) {
    return CheckLoginMobileDAO(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckLoginMobileDAO.fromJson(String source) =>
      CheckLoginMobileDAO.fromMap(json.decode(source) as Map<String, dynamic>);
}
