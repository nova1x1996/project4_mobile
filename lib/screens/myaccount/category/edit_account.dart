import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_hk4_mobile/const/const.dart';
import 'package:project_hk4_mobile/providers/AccountProvider.dart';
import 'package:project_hk4_mobile/screens/myaccount/category/edit_account_pass.dart';
import 'package:project_hk4_mobile/widget/MauInput2.dart';
import 'package:provider/provider.dart';

import '../../../model/Patient.dart';

class EditAccountPage extends StatefulWidget {
  static const routeName = "/EditAccountPage";

  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  late int IdPatient;
  late Patient patientModel;
  TextEditingController email = TextEditingController();

  TextEditingController address = TextEditingController();
  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();
  late ImagePicker picker;
  File? _imageFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    patientModel =
        Provider.of<AccountProvider>(context, listen: false).patient!;
    email.text = patientModel.email;
    address.text = patientModel.address;
    name.text = patientModel.name;
    phone.text = patientModel.phone;
    IdPatient = patientModel.id;
    picker = ImagePicker();
  }

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      Provider.of<AccountProvider>(context, listen: false)
          .updateImage(_imageFile!, IdPatient, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text(
          "Edit Account",
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
              child: Column(
                children: [
                  patientModel.image != null
                      ? AvatarEditAccount(patientModel.image.toString())
                      : AvatarNull(),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      _pickImage(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonEA(Icons.change_circle_outlined, "CHANGE PHOTO"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: bgColor1,
                    height: 1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MauInputReadonly(
                    label: "EMAIL",
                    placeholder: "placeholder",
                    controller: email,
                  ),
                  MauInput2(
                      label: "NAME",
                      placeholder: "Enter name",
                      controller: name),
                  MauInput2(
                      label: "ADDRESS",
                      placeholder: "Enter address",
                      controller: address),
                  MauInput2(
                      label: "PHONE",
                      placeholder: "Enter phone",
                      controller: phone),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, EditAccountPass.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonEA(
                            Icons.keyboard_alt_outlined, "CHANGE PASSWORD"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<AccountProvider>(context, listen: false)
                          .updateInfor(IdPatient, email.text, name.text,
                              address.text, phone.text, context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      child: Provider.of<AccountProvider>(context).isUpdateInfor
                          ? const Center(
                              child: SizedBox(
                                  height: 20,
                                  width: 80,
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  )),
                            )
                          : const Text(
                              "SAVE",
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
    );
  }

  Container ButtonEA(IconData icon_content, String content) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundInput,
          border: Border.all(color: colorEA_borderButton, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon_content,
            size: 20,
            color: colorEA_borderButton,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            content,
            style: TextStyle(
                fontSize: 13,
                color: colorEA_borderButton,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Container AvatarEditAccount(String img) {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image:
                DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)));
  }

  Container AvatarNull() {
    return Container(
      width: 100,
      height: 100,
      child: Icon(
        Icons.account_circle_rounded,
        size: 100,
        color: colorPrimary,
      ),
    );
  }
}
