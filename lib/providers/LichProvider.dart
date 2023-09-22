import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_hk4_mobile/model/Doctor.dart';
import 'package:project_hk4_mobile/model/LichLamViec.dart';
import '../const/ipbackend.dart';

class ThoiGianLichLamViecProvider extends ChangeNotifier {
  List<LichLamViec> listLLV = [];
  List<LichLamViec> get getlistLLV => listLLV;

  Future<List<LichLamViec>> getLichFromDoctor(int doctID) async {
    listLLV = [];
    //String apiGetList = ipBackend + "api/doctor";
    String apiGetLichFromDoctor =
        ipBackend + "api/lichlamviec/getfromdoctor/" + doctID.toString();

    try {
      var respone = await http.get(
        Uri.parse(apiGetLichFromDoctor),
      );

      if (respone.statusCode == 200) {
        var listMap = jsonDecode(respone.body) as List;

        List<LichLamViec> listLLVFake =
            listMap.map((e) => LichLamViec.fromMap(e)).toList();
        for (var item in listLLVFake) {
          if (item.date == DateTime.now() ||
              item.date.isAfter(DateTime.now())) {
            item.date = item.date.add(Duration(days: 1));
            listLLV.add(item);
          }
        }
      } else {
        return Future.error("Error");
      }
    } catch (e) {
      return Future.error(e);
      //Xuất hiện Popup " Đổi IP khác Wifi khác cho người dùngs"
    }

    return getlistLLV;
  }

  void checkList(int idLichlamviec) {
    for (var element in listLLV) {
      element.click = false;
      if (element.id == idLichlamviec) {
        element.click = true;
      }
    }
    notifyListeners();
    var a = listLLV;
  }
}
