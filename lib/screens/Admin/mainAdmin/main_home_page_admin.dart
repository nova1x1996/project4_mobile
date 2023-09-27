import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/providers/AccountProvider.dart';
import 'package:project_hk4_mobile/screens/Admin/mainAdmin/appointmentAdmin/appointment_admin.dart';
import 'package:project_hk4_mobile/screens/Admin/mainAdmin/ratingAdmin/rating_admin.dart';
import 'package:provider/provider.dart';

import '../../../const/const.dart';

class AdminHomePage extends StatefulWidget {
  static const routeName = "AdminHomePage";
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "Admin Page",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Admin"),
              accountEmail: Text("admin@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Colors.blueGrey,
                ),
              ),
            ),

            ListTile(
              title: Text(
                "Log out",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Provider.of<AccountProvider>(context, listen: false)
                    .logout(context);
                // Thêm xử lý khi người dùng chọn Option 2 ở đây
              },
            ),
            // Thêm các mục tùy chọn khác vào đây
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              cpn_category(),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Hot Themes",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 130,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      width: screenWidth * 0.7,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://images.unsplash.com/photo-1625134673337-519d4d10b313?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1538&q=80"),
                            fit: BoxFit.fill),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "12 JUL 2020",
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.tag,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "COVID-19 vaccine",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(
                                "Some Description",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class cpn_category extends StatelessWidget {
  const cpn_category({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppointmentAdmin.routeName);
          },
          child: Container(
            width: 160,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: colorBoderInput)),
            child: Column(
              children: [
                Icon(
                  Icons.book_outlined,
                  size: 45,
                  color: Colors.blueGrey,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Appointment",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: labelInput,
                      fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RatingAdmin.routeName);
          },
          child: Container(
            width: 160,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: colorBoderInput)),
            child: Column(
              children: [
                Icon(
                  Icons.star_border_purple500,
                  size: 45,
                  color: Colors.blueGrey,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Review",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: labelInput,
                      fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
