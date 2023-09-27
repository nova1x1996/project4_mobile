import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_hk4_mobile/screens/login/login_main.dart';
import 'package:project_hk4_mobile/screens/main/mainpage.dart';
import 'package:project_hk4_mobile/screens/myaccount/category/edit_account.dart';
import 'package:project_hk4_mobile/screens/myaccount/category/edit_account_pass.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/CheckLoginMobileDAO.dart';
import '../const/ipbackend.dart';
import '../model/Admin.dart';
import '../model/Patient.dart';
import '../widget/ShowDiagLog/ExampleSnackbar.dart';

class AccountProvider extends ChangeNotifier {
  String apiUrl = ipBackend + "api/accountpatient/checklogin";
  bool isLoading = false;
  bool isUpdateInfor = false;
  bool isChangePass = false;
  bool isRegister = false;
  Admin? admin;
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
        if (model["role"] == "ADMIN") {
          admin = Admin.fromMap(model);
          isLoading = false;
          notifyListeners();
          //Lưu vào bộ nhớ đệm
          SharedPreferences bnd = await SharedPreferences.getInstance();
          var jsonAdmin = admin!.toJson();
          bnd.setString("idAdmin", jsonAdmin);

          Navigator.pushNamedAndRemoveUntil(
            context,
            MainPage.routeName,
            (route) => false,
          );
        } else {
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

          FlushBarTopSuccess(context, "Login Success");
        }

        // FlushBarTopSuccess(context, "Login successfull");
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
      // FlushBarTopError(
      //     context, "An unexpected error occurred or  check internet !!!");

      //Xuất hiện Popup " Đổi IP khác Wifi khác cho người dùngs"
      print(e);
    }
  }

  Future<int> autoCheckLogin() async {
    SharedPreferences bnd = await SharedPreferences.getInstance();
    var result = bnd.getString("idPatient");
    SharedPreferences bndAdmin = await SharedPreferences.getInstance();
    var resultAdmin = bndAdmin.getString("idAdmin");

    if (result != null) {
      patient = Patient.fromJson(result!);
      admin = null;
      return 1;
    } else if (resultAdmin != null) {
      admin = Admin.fromJson(resultAdmin!);
      patient = null;
      return 2;
    } else {
      return 3;
    }
  }

  Future<bool> autoCheckLoginAdmin() async {
    SharedPreferences bnd = await SharedPreferences.getInstance();
    var result = bnd.getString("idAdmin");

    if (result != null) {
      admin = Admin.fromJson(result!);
      return true;
    } else {
      admin = null;
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
      String password, bool gender, String dob, BuildContext context) async {
//Convert sang Date

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
          "gender": gender,
          "dob": dob,
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
    admin = null;
    ;
    SharedPreferences bnd = await SharedPreferences.getInstance();
    bnd.remove("idPatient");
    bnd.remove("idAdmin");
    Navigator.pushNamedAndRemoveUntil(
      context,
      MainPage.routeName,
      (route) => false,
    );
  }

  Future<void> updateImage(
      File _imageFile, int Id, BuildContext context) async {
    String updateImageAPI =
        ipBackend + "api/patient/updateImage/" + Id.toString();

    //Check giới hạn file
    int fileSizeInBytes = await _imageFile.length();
    int maxFileSizeBytes = 1048576;
    if (fileSizeInBytes > maxFileSizeBytes) {
      FlushBarTopError(context, "The image must be smaller than 1MB.");
      return;
    }
    try {
      var request = http.MultipartRequest('PUT', Uri.parse(updateImageAPI));
      request.headers['Content-Type'] = 'image/png';
      request.files.add(await http.MultipartFile.fromPath(
          'file', _imageFile!.path,
          contentType: MediaType('image', 'jpg')));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        SharedPreferences bnd = await SharedPreferences.getInstance();
        Patient aaa = Patient.fromJson(responseBody.toString());
        patient = aaa;
        var jsonPatient = patient!.toJson();
        bnd.setString("idPatient", jsonPatient);
        notifyListeners();
        Navigator.pushReplacementNamed(context, EditAccountPage.routeName);
        FlushBarTopSuccess(context, "Update avatar success !");
      } else {
        // Xử lý lỗi
        FlushBarTopError(context, "Update avatar failed ! Try late");
      }
    } catch (ex) {
      print(ex);
      FlushBarTopError(context, "Update avatar failed !  Try late");
    }
  }
}
