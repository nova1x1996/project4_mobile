// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TypeDoctor {
  int id;
  String name;

  TypeDoctor({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory TypeDoctor.fromMap(Map<String, dynamic> map) {
    return TypeDoctor(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeDoctor.fromJson(String source) =>
      TypeDoctor.fromMap(json.decode(source) as Map<String, dynamic>);
}
