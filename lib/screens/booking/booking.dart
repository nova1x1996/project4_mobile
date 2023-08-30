import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/const/const.dart';
import 'package:project_hk4_mobile/widget/TextTitleMedium.dart';

class BookingPage extends StatefulWidget {
  static const routeName = "/BookingPage";
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text(
          "Booking",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          color: bgColor1,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // Điều chỉnh vị trí đổ bóng
              ),
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvatarDoctor_Booking(),
                const SizedBox(
                  height: 15,
                ),
                TextTitleMedium("Select day"),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: bgColor1,
                  ),
                  child: Text(
                    "27/09",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextTitleMedium("Select time slot"),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 250,
                  width: double.infinity,
                  child: GridView.builder(
                    itemCount: 20,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 45,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: bgColor1,
                        ),
                        child: Text(
                          "9:00 - 9:30",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center AvatarDoctor_Booking() {
    return Center(
        child: Column(
      children: [
        Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1594824476967-48c8b964273f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80"),
                    fit: BoxFit.cover))),
        SizedBox(
          height: 10,
        ),
        Text(
          "Dr.Alicia Stanger",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          "Ophthalmologist",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: colorTextSubtitle),
        ),
        Text(
          "20 Years",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Container(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "5.0",
                style: TextStyle(
                    color: colorPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              SizedBox(
                width: 5,
              ),
              ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: colorPrimary,
                  size: 20,
                ),
                separatorBuilder: (context, index) => SizedBox(
                  width: 2,
                ),
                itemCount: 5,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
