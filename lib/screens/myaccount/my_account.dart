import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/const/const.dart';
import 'package:project_hk4_mobile/providers/AccountProvider.dart';
import 'package:project_hk4_mobile/screens/myaccount/category/edit_account.dart';
import 'package:project_hk4_mobile/screens/payment/payment_history.dart';
import 'package:project_hk4_mobile/widget/ShowDiagLog/log_out.dart';
import 'package:project_hk4_mobile/widget/TextTitleMedium.dart';
import 'package:provider/provider.dart';

import '../../model/Patient.dart';

class MyAccountPage extends StatefulWidget {
  static const routeName = "/MyAccountPage";
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    Patient? patient = Provider.of<AccountProvider>(context).patient;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        width: double.infinity,
        color: bgColor1,
        height: screenHeight,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    patient!.image != null
                        ? Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              image: DecorationImage(
                                  image:
                                      NetworkImage(patient!.image.toString()),
                                  fit: BoxFit.cover),
                            ),
                          )
                        : Container(
                            width: 80,
                            height: 80,
                            child: Icon(
                              Icons.account_circle_rounded,
                              size: 80,
                              color: colorPrimary,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                            )),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patient!.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          patient!.address,
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 1,
                  color: bgColor1,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, EditAccountPage.routeName);
                    },
                    child: CategoryAccount(Icons.edit_square, "Edit Account")),
                Divider(
                  height: 1,
                  color: bgColor1,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, PaymentHistory.routeName);
                    },
                    child: CategoryAccount(
                        Icons.payments_outlined, "Payment History")),
                Divider(
                  height: 1,
                  color: bgColor1,
                ),
                InkWell(
                    onTap: () {
                      showLogoutDialog(context);
                    },
                    child: CategoryAccount(Icons.logout_outlined, "Log out")),
              ],
            ),
          ),
        ]));
  }

  Padding CategoryAccount(IconData iconcontent, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: bgColor1, borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  iconcontent,
                  color: colorPrimary,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(content,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
            ],
          ),
          Icon(
            Icons.keyboard_arrow_right_outlined,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
