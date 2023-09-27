import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_hk4_mobile/const/ipbackend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Appointment.dart';
import '../model/Patient.dart';

class HistoryAppointment extends ChangeNotifier {
  List<Appointment> listAppointment = [];

  Future<List<Appointment>> getListDoctor() async {
    SharedPreferences bnd = await SharedPreferences.getInstance();
    var result = bnd.getString("idPatient");

    Patient patient = Patient.fromJson(result!);
    //String apiGetList = ipBackend + "api/doctor";
    String apiGetListRating =
        ipBackend + "api/appointment/getAllByPatient/" + patient.id.toString();

    try {
      var respone = await http.get(
        Uri.parse(apiGetListRating),
      );

      if (respone.statusCode == 200) {
        var listMap = jsonDecode(respone.body) as List;

        listAppointment = listMap.map((e) => Appointment.fromJson(e)).toList();
      } else {
        return Future.error("Error");
      }
    } catch (e) {
      return Future.error(e);
      //Xuất hiện Popup " Đổi IP khác Wifi khác cho người dùngs"
    }

    return listAppointment;
  }
}
