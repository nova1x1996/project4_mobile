import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project_hk4_mobile/model/Doctor.dart';
import 'package:project_hk4_mobile/model/LichLamViec.dart';
import 'package:project_hk4_mobile/providers/FilterProvider.dart';
import 'package:project_hk4_mobile/screens/payment/payment_history.dart';
import 'package:project_hk4_mobile/screens/payment/payment_success.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/ipbackend.dart';
import '../model/GioLamViec.dart';
import '../model/Patient.dart';

class DoctorProvider extends ChangeNotifier {
  DateTime? ngaylamviec;
  String? thoigian;
  List<Doctor> listDoctor = [];
  List<LichLamViec> listLLV = [];
  List<GioLamViec> listGioLamViecREALTIME = [];
  List<GioLamViec> get getlistGioLamViec => listGioLamViecREALTIME;
  List<LichLamViec> get getlistLLV => listLLV;
  List<Doctor> get getList => listDoctor;
  int count = 0;
  Future<List<Doctor>> getListDoctor(String search) async {
    //String apiGetList = ipBackend + "api/doctor";
    String apiGetListRating =
        ipBackend + "api/doctor/withrating/search=" + search;

    try {
      var respone = await http.get(
        Uri.parse(apiGetListRating),
      );

      if (respone.statusCode == 200) {
        var listMap = jsonDecode(respone.body) as List;
        var a = listMap;
        listDoctor = listMap.map((e) => Doctor.fromMap(e[0], e[1])).toList();
      } else {
        return Future.error("Error");
      }
    } catch (e) {
      return Future.error(e);
      //Xuất hiện Popup " Đổi IP khác Wifi khác cho người dùngs"
    }

    return listDoctor;
  }

  Future<List<LichLamViec>> getLichFromDoctor(int doctID) async {
    listLLV = [];

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
        ngaylamviec = element.date;
      }
    }
    listGioLamViecREALTIME = [];
    getGioLamViec();
    notifyListeners();
  }

  Future<List<GioLamViec>> getGioLamViec() async {
    // List<GioLamViec> listGioLamViecREALTIME = [];
    bool flag = false;
    LichLamViec? objLLV;
    for (var element in listLLV) {
      if (element.click) {
        objLLV = element;
        flag = true;
        break;
      }
    }
    if (flag == false) {
      return [];
    }

    if (objLLV!.starttime == "07:00:00") {
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "7:00 - 7:30"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "7:30 - 8:00"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "8:00 - 8:30"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "8:30 - 9:00"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "9:00 - 9:30"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "9:30 - 10:00"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "10:00 - 10:30"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "10:30 - 11:00"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "11:00 - 11:30"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "11:30 - 12:00"));
    } else if (objLLV!.starttime == "12:00:00") {
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "12:00 - 12:30"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "12:30 - 13:00"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "13:00 - 13:30"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "13:30 - 14:00"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "14:00 - 14:30"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "14:30 - 15:00"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "15:00 - 15:30"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "15:30 - 16:00"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "16:00 - 16:30"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "16:30 - 17:00"));
    } else if (objLLV!.starttime == "17:00:00") {
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "17:00 - 17:30"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "17:30 - 18:00"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "18:00 - 18:30"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "18:30 - 19:00"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "19:00 - 19:30"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "19:30 - 20:00"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "20:00 - 20:30"));
      listGioLamViecREALTIME.add(GioLamViec(thoigian: "20:30 - 21:00"));
    }
    return listGioLamViecREALTIME;
  }

  void checkListGioLamViec(String GioLamViec) {
    for (var element in listGioLamViecREALTIME) {
      element.click = false;
      if (element.thoigian == GioLamViec) {
        element.click = true;
        thoigian = element.thoigian;
      }
    }
    notifyListeners();
  }

  void makeAppointment(String GioLamViec) {
    for (var element in listGioLamViecREALTIME) {
      element.click = false;
      if (element.thoigian == GioLamViec) {
        element.click = true;
        thoigian = element.thoigian;
      }
    }
    notifyListeners();
  }

  void PaymentBooking(
      int idDoctor, String Sympton, BuildContext context) async {
    String apiCreateAppointment = ipBackend + "api/appointment";
    bool flag = false;
    LichLamViec? objLLV;
    GioLamViec? objGLV;

    for (var element in listLLV) {
      if (element.click) {
        objLLV = element;
        flag = true;
        break;
      }
    }

    for (var element2 in listGioLamViecREALTIME) {
      if (element2.click) {
        objGLV = element2;
        flag = true;
        break;
      }
    }
    if (objGLV == null) {
      return;
    }
    SharedPreferences bnd = await SharedPreferences.getInstance();
    var result = bnd.getString("idPatient");

    var patient = Patient.fromJson(result!);
    print(patient.id);
    print(ngaylamviec);
    print(objGLV);

    List<String> parts = objGLV!.thoigian.split(' - ');

    String startTime = parts[0];
    String endTime = parts[1];

    try {
      List<String> parts = objGLV!.thoigian.split(' - ');

      String startTime = parts[0];
      String endTime = parts[1];
      var respone = await http.post(
        Uri.parse(apiCreateAppointment),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
        body: jsonEncode({
          "starttime": startTime + ":00",
          "endtime": endTime + ":00",
          "symptom": Sympton,
          "price": 50,
          "doctorId": idDoctor,
          "patientId": patient.id,
          "date": DateFormat('yyyy-MM-dd').format(ngaylamviec!)
        }),
      );
      var a = respone.body;
      if (respone.statusCode == 200) {
        Navigator.pushNamedAndRemoveUntil(
            context, PaymentSuccessPage.routeName, (route) => false);
      }
    } catch (e) {
      print(e);
    }
  }
}
