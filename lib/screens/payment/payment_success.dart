import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/const/const.dart';
import 'package:project_hk4_mobile/screens/main/mainpage.dart';

class PaymentSuccessPage extends StatelessWidget {
  static const routeName = "/PaymentSuccessPage";
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.check_circle,
              color: Colors.green[400],
              size: 120,
            ),
          ),
          Text(
            "Thank You!",
            style: TextStyle(
                color: Colors.green[400],
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Your payment was done successfully",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, MainPage.routeName, (route) => false);
            },
            child: Container(
              width: screenWidth * 0.8,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: colorPrimary, borderRadius: BorderRadius.circular(15)),
              child: Text(
                "HOME",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
