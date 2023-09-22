import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_hk4_mobile/screens/login/login_main.dart';
import 'package:project_hk4_mobile/screens/main/mainpage.dart';
import 'package:project_hk4_mobile/screens/myaccount/category/edit_account.dart';
import 'package:project_hk4_mobile/screens/myaccount/category/edit_account_pass.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/CheckLoginMobileDAO.dart';
import '../const/ipbackend.dart';
import '../model/Patient.dart';
import '../widget/ShowDiagLog/ExampleSnackbar.dart';

class AccountProvider extends ChangeNotifier {
  String apiUrl = ipBackend + "api/accountpatient/checklogin";
  bool isLoading = false;
  bool isUpdateInfor = false;
  bool isChangePass = false;
  bool isRegister = false;

  Patient? patient;

  Future<void> test() async {
    try {
      var respone = await http.get(
        Uri.parse(apiUrl),
      );
      var a = respone.body;
    } catch (e) {
      //Xuất hiện Popup " Đổi IP khác Wifi khác cho người dùngs"
      print(e);
    }
  }

  Future<void> dangnhap(String mail, String pass, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      var respone = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
        body: jsonEncode({
          "email": mail,
          "password": pass,
        }),
      );
      if (respone.statusCode == 200) {
        var model = jsonDecode(respone.body) as Map<String, dynamic>;
        patient = Patient.fromMap(model);
        isLoading = false;
        notifyListeners();
        //Lưu vào bộ nhớ đệm
        SharedPreferences bnd = await SharedPreferences.getInstance();
        var jsonPatient = patient!.toJson();
        bnd.setString("idPatient", jsonPatient);

        Navigator.pushNamedAndRemoveUntil(
          context,
          MainPage.routeName,
          (route) => false,
        );
        FlushBarTopSuccess(context, "Login successfull");
      } else if (respone.statusCode == 404) {
        isLoading = false;
        notifyListeners();
        FlushBarTopError(context, "Email or password is incorrect !!!");
      } else if (respone.statusCode == 400) {
        isLoading = false;
        notifyListeners();
        FlushBarTopError(context, "An unexpected error occurred !!!");

        //Da xay ra loi khong mong muon trycatch
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      FlushBarTopError(
          context, "An unexpected error occurred or  check internet !!!");

      //Xuất hiện Popup " Đổi IP khác Wifi khác cho người dùngs"
      print(e);
    }
  }

  Future<bool> autoCheckLogin() async {
    SharedPreferences bnd = await SharedPreferences.getInstance();
    var result = bnd.getString("idPatient");

    if (result != null) {
      patient = Patient.fromJson(result!);
      return true;
    } else {
      patient = null;
      return false;
    }
  }

  Future<void> updateInfor(int Id, String mail, String name, String address,
      String phone, BuildContext context) async {
    isUpdateInfor = true;
    notifyListeners();
    String updateInforAPI = ipBackend + "api/patient/" + Id.toString();

    try {
      var respone = await http.put(
        Uri.parse(updateInforAPI),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
        body: jsonEncode(
            {"email": mail, "name": name, "address": address, "phone": phone}),
      );
      if (respone.statusCode == 200) {
        var model = jsonDecode(respone.body) as Map<String, dynamic>;
        patient = Patient.fromMap(model);
        isUpdateInfor = false;
        FlushBarTopSuccess(context, "Update account success");
        notifyListeners();
        // Navigator.pushNamedAndRemoveUntil(
        //   context,
        //   MainPage.routeName,
        //   (route) => false,
        // );
      } else {
        isUpdateInfor = false;
        FlushBarTopError(context, "Update failed !!!");
      }
    } catch (e) {
      isUpdateInfor = false;
      FlushBarTopError(context, "Update failed !!!");
      notifyListeners();
      //Xuất hiện Popup " Đổi IP khác Wifi khác cho người dùngs"
      print(e);
    }
  }

  Future<void> updatePass(int Id, String pass, BuildContext context) async {
    isChangePass = true;
    notifyListeners();
    String updateInforAPI = ipBackend + "api/patient/" + Id.toString();

    try {
      var respone = await http.put(
        Uri.parse(updateInforAPI),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
        body: jsonEncode({
          "password": pass,
        }),
      );
      if (respone.statusCode == 200) {
        var model = jsonDecode(respone.body) as Map<String, dynamic>;
        patient = Patient.fromMap(model);
        isChangePass = false;

        notifyListeners();
        Navigator.popAndPushNamed(context, EditAccountPass.routeName);
        FlushBarTopSuccess(context, "Change password success");
      } else {
        isChangePass = false;
        FlushBarTopError(context, "Change password failed !!!");
      }
    } catch (e) {
      isChangePass = false;
      FlushBarTopError(context, "Change password failed !!!");
      notifyListeners();
      //Xuất hiện Popup " Đổi IP khác Wifi khác cho người dùngs"
      print(e);
    }
  }

  Future<void> register(String email, String name, String address, String phone,
      String password, BuildContext context) async {
    isRegister = true;
    notifyListeners();
    String registerPatient = ipBackend + "api/patient/";

    try {
      var respone = await http.post(
        Uri.parse(registerPatient),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "address": address,
          "phone": phone,
          "password": password,
        }),
      );

      if (respone.statusCode == 201 || respone.statusCode == 200) {
        isRegister = false;
        notifyListeners();
        Navigator.popAndPushNamed(context, LoginMain.routeName);
        FlushBarTopSuccess(context, "Register Success !!!");
      } else {
        isRegister = false;
        notifyListeners();
        FlushBarTopError(context, "Register failed !!!");
      }
    } catch (e) {
      isRegister = false;
      FlushBarTopError(context, e.toString());
      notifyListeners();
      //Xuất hiện Popup " Đổi IP khác Wifi khác cho người dùngs"
    }
  }

  Future<void> logout(BuildContext context) async {
    patient = null;

    SharedPreferences bnd = await SharedPreferences.getInstance();
    bnd.remove("idPatient");
    Navigator.pushNamedAndRemoveUntil(
      context,
      MainPage.routeName,
      (route) => false,
    );
  }
}
