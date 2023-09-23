import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/const/const.dart';
import 'package:project_hk4_mobile/providers/AccountProvider.dart';
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
    return (checkPatient != null)
        ? MainHomePage()
        : FutureBuilder(
            initialData: false,
            future: Provider.of<AccountProvider>(context).autoCheckLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return (snapshot.data!) ? MainHomePage() : LoginMain();
            },
          );
  }
}
