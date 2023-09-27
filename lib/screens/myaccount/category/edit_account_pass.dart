import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/const.dart';
import '../../../providers/AccountProvider.dart';
import '../../../validate/validateAllFields.dart';
import '../../../widget/MauInput2.dart';
import '../../../widget/ShowDiagLog/ExampleSnackbar.dart';

class EditAccountPass extends StatefulWidget {
  static const routeName = "/EditAccountPass";
  const EditAccountPass({super.key});

  @override
  State<EditAccountPass> createState() => _EditAccountPassState();
}

class _EditAccountPassState extends State<EditAccountPass> {
  var validateAF = validateAllFields();
  final formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();
  late int IdPatient;
  void initState() {
    // TODO: implement initState
    super.initState();

    IdPatient =
        Provider.of<AccountProvider>(context, listen: false).patient!.id;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text(
          "Change Password",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Container(
        height: double.infinity,
        color: bgColor1,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    MauInput2(
                        label: "PASSWORD",
                        placeholder: "Enter password",
                        kieuValidate: "password",
                        controller: password,
                        password: true),
                    MauInput2(
                        label: "CONFIRM PASSWORD",
                        kieuValidate: "password",
                        placeholder: "Enter confirm password",
                        controller: confirmPassword,
                        password: true),
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if (password.text != confirmPassword.text) {
                            FlushBarTopError(context,
                                "Password and password confirmation do not match");
                            return;
                          }

                          Provider.of<AccountProvider>(context, listen: false)
                              .updatePass(IdPatient, password.text, context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        child:
                            Provider.of<AccountProvider>(context).isUpdateInfor
                                ? const Center(
                                    child: SizedBox(
                                        height: 20,
                                        width: 80,
                                        child: CircularProgressIndicator(
                                          color: Colors.blue,
                                        )),
                                  )
                                : const Text(
                                    "CHANGE PASSWORD",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
