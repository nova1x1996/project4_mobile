import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/screens/login/login_main.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';
import '../../providers/AccountProvider.dart';
import '../../widget/MauInput2.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "/Register";
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController txt_email = TextEditingController();
  TextEditingController txt_password = TextEditingController();
  TextEditingController txt_name = TextEditingController();
  TextEditingController txt_phone = TextEditingController();
  TextEditingController txt_address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var checkLoading =
        Provider.of<AccountProvider>(context, listen: true).isLoading;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                height: screenHeight / 3,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/login/header.png"),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.2,
                    ),
                    Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Please enter your credentials to proceed",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                color: Colors.white,
                child: Column(
                  children: [
                    MauInput2(
                        label: "NAME",
                        placeholder: "Please enter your name",
                        controller: txt_name),
                    MauInput2(
                      label: "EMAIL",
                      placeholder: "Please enter your email",
                      controller: txt_email,
                    ),
                    MauInput2(
                        label: "ADDRESS",
                        placeholder: "Please enter your address",
                        controller: txt_address),
                    MauInput2(
                      label: "PHONE",
                      placeholder: "Please enter your phone",
                      controller: txt_phone,
                    ),
                    MauInput2(
                        label: "PASSWORD",
                        placeholder: "Please enter your password",
                        controller: txt_password,
                        password: true),
                    MauInput2(
                        label: "CONFIRM PASSWORD",
                        placeholder: "Please enter confirm password",
                        controller: txt_password,
                        password: true),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<AccountProvider>(context, listen: false)
                            .register(
                                txt_email.text,
                                txt_name.text,
                                txt_address.text,
                                txt_phone.text,
                                txt_password.text,
                                context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 13),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(5)),
                        child: checkLoading
                            ? Center(
                                child: SizedBox(
                                    height: 20,
                                    width: 80,
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    )),
                              )
                            : Center(
                                child: Text(
                                "SUBMIT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 15, color: placeholderInput),
                            children: [
                              TextSpan(text: "You already have an account? "),
                              TextSpan(
                                text: 'Log In',
                                style: TextStyle(
                                    color: colorPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Đoạn này thực hiện điều hướng khi người dùng bấm vào "Đăng ký"
                                    Navigator.pushNamed(
                                        context, LoginMain.routeName);
                                  },
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
