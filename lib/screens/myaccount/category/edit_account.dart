import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/const/const.dart';
import 'package:project_hk4_mobile/widget/MauInput2.dart';

class EditAccountPage extends StatefulWidget {
  static const routeName = "/EditAccountPage";

  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  TextEditingController _name = TextEditingController();
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
                  AvatarEditAccount(),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonEA(Icons.change_circle_outlined, "CHANGE PHOTO"),
                    ],
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
                  MauInput2(
                      label: "NAME",
                      placeholder: "placeholder",
                      controller: _name),
                  MauInput2(
                      label: "EMAIL",
                      placeholder: "placeholder",
                      controller: _name),
                  MauInput2(
                      label: "PASSWORD",
                      placeholder: "placeholder",
                      controller: _name),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonEA(Icons.keyboard_alt_outlined, "CHANGE PASSWORD"),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
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

  Container AvatarEditAccount() {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1594824476967-48c8b964273f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80"),
                fit: BoxFit.cover)));
  }
}
