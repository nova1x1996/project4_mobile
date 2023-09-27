import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/providers/FilterProvider.dart';
import 'package:project_hk4_mobile/screens/alldoctor/alldoctor.dart';
import 'package:project_hk4_mobile/screens/homepage/homepage.dart';
import 'package:project_hk4_mobile/screens/myaccount/my_account.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List ListPage = [HomePage(), AllDoctor(), MyAccountPage()];
  List ListTitlePage = ["Home Page", "All Doctors", "My Account"];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 120,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: colorPrimary),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ListTitlePage[_selectedIndex],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              onSubmitted: (value) {
                Provider.of<FilterProvider>(context, listen: false)
                    .changeSearchContent(value);

                _onItemTapped(1);
              },
              decoration: InputDecoration(
                fillColor: backgroundInput2,
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                labelText: "Search Doctors ...",
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.3, color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.3, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListPage[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 26,
        selectedFontSize: 0,
        selectedIconTheme: IconThemeData(color: colorPrimary),
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety_outlined),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
