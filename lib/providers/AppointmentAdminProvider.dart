import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_hk4_mobile/model/Appointment.dart';
import 'package:http/http.dart' as http;
import '../const/ipbackend.dart';
import '../model/filter/DayAppointment.dart';

class AppointmentAdminProvider extends ChangeNotifier {
  List<Appointment> listAppointment = [];
  List<DayAppointment> listDay = [
    DayAppointment(id: 1, name: "30 Days Ago"),
    DayAppointment(id: 2, name: "7 Days Ago"),
    DayAppointment(id: 3, name: "Today", click: true),
    DayAppointment(id: 4, name: "7 Days Later"),
    DayAppointment(id: 5, name: "30 Days Later"),
    DayAppointment(id: 6, name: "All"),
  ];

  var formatter = DateFormat('yyyy-MM-dd');

  Future<List<Appointment>> getListRating() async {
    var today = DateTime.now();
    var formattedDate = formatter.format(today);
    String objStartDate;
    String objEndDate;
    String objClick = "";
    for (var item in listDay) {
      if (item.click == true) {
        objClick = item.name;
      }
    }
    switch (objClick) {
      case "Today":
        objStartDate = formatter.format(DateTime.now());
        objEndDate = formatter.format(DateTime.now());
        break;
      case "7 Days Later":
        objStartDate = formatter.format(DateTime.now());
        objEndDate = formatter.format(DateTime.now().add(Duration(days: 7)));

        break;
      case "7 Days Ago":
        objStartDate =
            formatter.format(DateTime.now().subtract(Duration(days: 7)));
        objEndDate = formatter.format(DateTime.now());

        break;
      case "30 Days Ago":
        objStartDate =
            formatter.format(DateTime.now().subtract(Duration(days: 30)));
        objEndDate = formatter.format(DateTime.now());

        break;
      case "All":
        objStartDate = "";
        objEndDate = "";
        break;
      case "30 Days Later":
        objStartDate = formatter.format(DateTime.now());
        objEndDate = formatter.format(DateTime.now().add(Duration(days: 30)));
      default:
        objStartDate = "";
        objEndDate = "";
        break;
    }

    String apiUrl = ipBackend +
        'api/appointment/filter/startdate=' +
        objStartDate +
        '&enddate=' +
        objEndDate;

    try {
      var respone = await http.get(
        Uri.parse(apiUrl),
      );

      if (respone.statusCode == 200) {
        var listMap = jsonDecode(respone.body) as List;
        var a = listMap;
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

  void checkList(int id) {
    for (var element in listDay) {
      element.click = false;
      if (element.id == id) {
        element.click = true;
      }
    }

    notifyListeners();
  }
}
