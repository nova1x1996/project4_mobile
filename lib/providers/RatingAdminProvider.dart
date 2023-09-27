import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../const/ipbackend.dart';
import '../model/Rating.dart';
import '../model/filter/Day.dart';

class RatingAdminProvider extends ChangeNotifier {
  List<Rating> listRating = [];
  List<Day> listDay = [
    Day(id: 1, name: "Today", click: true),
    Day(id: 2, name: "7 Day"),
    Day(id: 3, name: "All")
  ];

  var formatter = DateFormat('yyyy-MM-dd');

  Future<List<Rating>> getListRating() async {
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
      case "7 Day":
        objStartDate =
            formatter.format(DateTime.now().subtract(Duration(days: 7)));
        objEndDate = formatter.format(DateTime.now());
        break;
      case "All":
        objStartDate = "";
        objEndDate = "";
        break;
      default:
        objStartDate = "";
        objEndDate = "";
        break;
    }

    String apiUrl = ipBackend +
        'api/rating/filter/startdate=' +
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
        listRating = listMap.map((e) => Rating.fromJson(e)).toList();
      } else {
        return Future.error("Error");
      }
    } catch (e) {
      return Future.error(e);
      //Xuất hiện Popup " Đổi IP khác Wifi khác cho người dùngs"
    }

    return listRating;
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
