import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_hk4_mobile/screens/login/login_main.dart';
import 'package:project_hk4_mobile/widget/ShowDiagLog/ExampleSnackbar.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';
import '../../providers/AccountProvider.dart';
import '../../widget/MauInput2.dart';
import '../../validate/validateAllFields.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "/Register";
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool txt_gender = false;
  var txt_date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var validateAF = validateAllFields();
  final formKey = GlobalKey<FormState>();
  TextEditingController txt_email = TextEditingController();
  TextEditingController txt_password = TextEditingController();
  TextEditingController txt_confirmpassword = TextEditingController();

  TextEditingController txt_name = TextEditingController();
  TextEditingController txt_phone = TextEditingController();
  TextEditingController txt_address = TextEditingController();

  FocusNode fc_Phone = FocusNode();
  FocusNode fc_Name = FocusNode();

  FocusNode fc_Gender = FocusNode();

  FocusNode fc_Address = FocusNode();
  FocusNode fc_Email = FocusNode();
  FocusNode fc_Password = FocusNode();
  FocusNode fc_ConfirmPass = FocusNode();
  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1923),
            lastDate: DateTime.now())
        .then((value) => {
              if (value != null)
                {
                  setState(() {
                    txt_date = DateFormat('yyyy-MM-dd').format(value!);
                  })
                }
            });
  }

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
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      MauInput2(
                          label: "NAME",
                          context: context,
                          placeholder: "Please enter your name",
                          controller: txt_name,
                          currentFocus: fc_Name,
                          nextFocus: fc_Email,
                          kieuValidate: "fullname"),
                      MauInput2(
                        label: "EMAIL",
                        context: context,
                        kieuValidate: "email",
                        currentFocus: fc_Email,
                        nextFocus: fc_Address,
                        placeholder: "Please enter your email",
                        controller: txt_email,
                      ),
                      MauInput2(
                          label: "ADDRESS",
                          context: context,
                          currentFocus: fc_Address,
                          nextFocus: fc_Phone,
                          kieuValidate: "address",
                          placeholder: "Please enter your address",
                          controller: txt_address),
                      MauInput2(
                        label: "PHONE",
                        context: context,
                        currentFocus: fc_Phone,
                        nextFocus: fc_Password,
                        kieuValidate: "phone",
                        placeholder: "Please enter your phone",
                        controller: txt_phone,
                      ),
                      MauInput2(
                          label: "PASSWORD",
                          context: context,
                          currentFocus: fc_Password,
                          nextFocus: fc_ConfirmPass,
                          kieuValidate: "password",
                          placeholder: "Please enter your password",
                          controller: txt_password,
                          password: true),
                      MauInput2(
                          label: "CONFIRM PASSWORD",
                          context: context,
                          kieuValidate: 'password',
                          currentFocus: fc_ConfirmPass,
                          nextFocus: fc_Gender,
                          placeholder: "Please enter confirm password",
                          controller: txt_confirmpassword,
                          password: true),
                      Container(
                        width: double.infinity,
                        height: 80,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      "Gender",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: (txt_gender)
                                                  ? colorPrimary
                                                  : Colors.transparent,
                                              width: 4),
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          color: Colors.blue.withOpacity(
                                              0.6), // Màu nền trong suốt
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              txt_gender = true;
                                            });
                                          },
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            // Điều chỉnh padding dọc
                                            child: Icon(
                                              Icons.male,
                                              color: (txt_gender)
                                                  ? colorPrimary
                                                  : Colors.white,
                                              // Màu biểu tượng
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.0086),
                                      // Khoảng cách giữa các phần tử
                                      Container(
                                        width: 80,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: (!txt_gender)
                                                  ? colorPrimary
                                                  : Colors.transparent,
                                              width: 4),
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          color: Colors.pink.withOpacity(
                                              0.7), // Màu nền trong suốt
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              txt_gender = false;
                                            });
                                          },
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            // Điều chỉnh padding dọc
                                            child: Icon(
                                              Icons.female,
                                              color: (!txt_gender)
                                                  ? colorPrimary
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "DoB",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold),
                                ),
                                InkWell(
                                  onTap: () {
                                    _showDatePicker();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.calendar_month),
                                          Text(
                                            txt_date.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ]),
                                    width: double.infinity,
                                    height: 48,
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            if (txt_password.text != txt_confirmpassword.text) {
                              FlushBarTopError(context,
                                  "Password confirmation do not match.");
                              return;
                            }
                            Provider.of<AccountProvider>(context, listen: false)
                                .register(
                                    txt_email.text,
                                    txt_name.text,
                                    txt_address.text,
                                    txt_phone.text,
                                    txt_password.text,
                                    txt_gender,
                                    txt_date,
                                    context);
                          }
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
