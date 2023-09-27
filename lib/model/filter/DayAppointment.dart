// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

var formatterDungGioDB = DateFormat('HH:mm:ss dd/MM/yyyy', 'en_US');

class DayAppointment {
  int id;
  String name;
  bool click;
  DayAppointment({required this.id, required this.name, this.click = false});
}
