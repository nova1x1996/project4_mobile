import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/const/const.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: 300,
            child: Column(
              children: [
                SizedBox(height: 20),
                HeaderImageConfirmLogout(),
                const SizedBox(height: 20),
                const Text(
                  "Log out",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Text("Are you sure you want to log-out?"),
                const Spacer(),
                ButtonLogout(),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: ButtonCancel()),
              ],
            ),
          ),
          // actions: <Widget>[
          //   TextButton(
          //     style: TextButton.styleFrom(
          //       textStyle: Theme.of(context).textTheme.labelLarge,
          //     ),
          //     child: const Text('Disable'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          //   TextButton(
          //     style: TextButton.styleFrom(
          //       textStyle: Theme.of(context).textTheme.labelLarge,
          //     ),
          //     child: const Text('Enable'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      } // Trả về widget AlertDialog của bạn
      );
}

Container HeaderImageConfirmLogout() {
  return Container(
    width: 80,
    height: 80,
    decoration: BoxDecoration(
        color: bgColor1,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: colorPrimary, width: 1)),
    child: Icon(
      Icons.logout_outlined,
      color: colorPrimary,
      size: 50,
    ),
  );
}

Container ButtonLogout() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    width: double.infinity,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: colorPrimary, borderRadius: BorderRadius.circular(8)),
    child: const Text(
      "LOG OUT",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}

Container ButtonCancel() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    width: double.infinity,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        border: Border.all(color: colorPrimary),
        color: bgColor1,
        borderRadius: BorderRadius.circular(8)),
    child: Text(
      "CANCEL",
      style: TextStyle(color: colorPrimary, fontWeight: FontWeight.bold),
    ),
  );
}
