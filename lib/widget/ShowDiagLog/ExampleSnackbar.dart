import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void SnackBarShowError(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.info,
            color: Colors.white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(content),
        ],
      ),
      duration: Duration(seconds: 2), // Đặt thời gian hiển thị
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 80),
    ),
  );
}

void SnackBarShowSuccess(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.check_circle_sharp,
            color: Colors.white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(content),
        ],
      ),
      duration: Duration(seconds: 2), // Đặt thời gian hiển thị
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 80),
    ),
  );
}

void FlushBarTopSuccess(BuildContext context, String content) {
  Flushbar(
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    message: content,
    backgroundColor: Colors.lightGreen,
    messageSize: 16,
    icon: Icon(Icons.error_outline, color: Colors.white),
  )..show(context);
}

void FlushBarTopError(BuildContext context, String content) {
  Flushbar(
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    message: content,
    backgroundColor: Colors.red,
    messageSize: 16,
    icon: Icon(Icons.error_outline, color: Colors.white),
  )..show(context);
}
