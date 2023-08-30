import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/screens/booking/booking.dart';

import '../../const/const.dart';
import '../../widget/TextTitleMedium.dart';

class AllDoctor extends StatefulWidget {
  static const routeName = "/AllDoctor";
  const AllDoctor({super.key});

  @override
  State<AllDoctor> createState() => _AllDoctorState();
}

class _AllDoctorState extends State<AllDoctor> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        color: bgColor1,
        height: screenHeight,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextTitleMedium("Doctor List"),
                Row(
                  children: [
                    Text(
                      "Card View",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: labelInput),
                    ),
                    Icon(
                      Icons.h_mobiledata,
                      color: labelInput,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Điều chỉnh vị trí đổ bóng
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 10),
                      width: double.infinity,
                      height: 130,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Jone Doe",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19),
                                      ),
                                      Text(
                                        "Ophthalmologist",
                                        style: TextStyle(
                                            color: colorTextSubtitle,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "ssssssssssss",
                                        style: TextStyle(
                                            color: colorTextSubtitle,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    color: bgColor1,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: colorPrimary,
                                      size: 20,
                                    ),
                                    Text(
                                      "4.7",
                                      style: TextStyle(color: colorPrimary),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.emoji_emotions_outlined,
                                    size: 20,
                                    color: colorPrimary,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Female",
                                    style: TextStyle(
                                        fontSize: 13, color: colorPrimary),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, BookingPage.routeName);
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: colorPrimary, width: 1)),
                                      child: Icon(
                                        Icons.calendar_month_outlined,
                                        color: colorPrimary,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 15,
                    ),
                itemCount: 5),
          ],
        ),
      ),
    );
  }
}
