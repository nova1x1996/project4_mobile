import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/const/const.dart';
import 'package:project_hk4_mobile/providers/AccountProvider.dart';
import 'package:project_hk4_mobile/screens/Admin/mainAdmin/main_home_page_admin.dart';
import 'package:project_hk4_mobile/screens/alldoctor/alldoctor.dart';
import 'package:project_hk4_mobile/screens/homepage/homepage.dart';
import 'package:project_hk4_mobile/screens/login/login_main.dart';
import 'package:project_hk4_mobile/screens/main/main_home_page.dart';
import 'package:project_hk4_mobile/screens/myaccount/my_account.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  static const routeName = "/";
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var checkPatient =
        Provider.of<AccountProvider>(context, listen: false).patient;
    var checkAdmin = Provider.of<AccountProvider>(context, listen: false).admin;
    if (checkAdmin != null) {
      return AdminHomePage();
    }
    return (checkPatient != null)
        ? MainHomePage()
        : FutureBuilder(
            initialData: false,
            future: Provider.of<AccountProvider>(context, listen: false)
                .autoCheckLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.data == 1) {
                return MainHomePage();
              } else if (snapshot.data == 2) {
                return AdminHomePage();
              }
              return LoginMain();
            },
          );
  }
}
