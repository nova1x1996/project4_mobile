import 'dart:convert';

class LichLamViec {
  final int id;
  final String thu;
  DateTime date;
  final DateTime createAt;
  final String starttime;
  final String endtime;
  bool click = false;

  LichLamViec({
    required this.id,
    required this.thu,
    required this.date,
    required this.createAt,
    required this.starttime,
    required this.endtime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'thu': thu,
      'date': date.millisecondsSinceEpoch,
      'createAt': createAt.millisecondsSinceEpoch,
      'starttime': starttime,
      'endtime': endtime,
    };
  }

  factory LichLamViec.fromMap(Map<String, dynamic> map) {
    return LichLamViec(
      id: map['id'] as int,
      thu: map['thu'] as String,
      date: DateTime.parse(map['date']),
      createAt: DateTime.parse(map['createAt']),
      starttime: map['starttime'] as String,
      endtime: map['endtime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LichLamViec.fromJson(String source) =>
      LichLamViec.fromMap(json.decode(source) as Map<String, dynamic>);
}
