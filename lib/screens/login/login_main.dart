import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/providers/AccountProvider.dart';
import 'package:project_hk4_mobile/screens/register/register.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';
import '../../widget/MauInput2.dart';

class LoginMain extends StatefulWidget {
  static const routeName = "/LoginMain";
  const LoginMain({super.key});

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  TextEditingController txt_email = TextEditingController();
  TextEditingController txt_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var checkLoading =
        Provider.of<AccountProvider>(context, listen: true).isLoading;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: double.infinity,
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
                      "Sign In",
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
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                color: Colors.white,
                child: Column(
                  children: [
                    MauInput2(
                        label: "EMAIL",
                        placeholder: "Email",
                        controller: txt_email),
                    MauInput2(
                        label: "PASSWORD",
                        placeholder: "Password",
                        controller: txt_password,
                        password: true),
                    Text("Forget Password ?",
                        style: TextStyle(color: colorPrimary, fontSize: 15)),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Provider.of<AccountProvider>(context, listen: false)
                            .dangnhap(
                                txt_email.text, txt_password.text, context);
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
                                "SIGN IN",
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
                              TextSpan(text: "Don't have an account?"),
                              TextSpan(
                                  text: ' Sign Up',
                                  style: TextStyle(
                                      color: colorPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, RegisterPage.routeName);
                                    }
                                  /* recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Đoạn này thực hiện điều hướng khi người dùng bấm vào "Đăng ký"
                                    Navigator.pushNamed(context, '/Register');
                                  },*/
                                  )
                            ]),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
