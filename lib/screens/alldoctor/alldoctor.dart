import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/providers/DoctorProvider.dart';
import 'package:project_hk4_mobile/providers/FilterProvider.dart';
import 'package:project_hk4_mobile/screens/booking/booking.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';
import '../../model/Doctor.dart';
import '../../widget/TextTitleMedium.dart';

class AllDoctor extends StatefulWidget {
  static const routeName = "/AllDoctor";
  AllDoctor({super.key});

  @override
  State<AllDoctor> createState() => _AllDoctorState();
}

class _AllDoctorState extends State<AllDoctor> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String search = Provider.of<FilterProvider>(context, listen: true).search;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: bgColor1,
      child: SingleChildScrollView(
        child: Container(
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
              FutureBuilder(
                future: Provider.of<DoctorProvider>(context, listen: false)
                    .getListDoctor(search),
                builder: (context, snapshot) {
                  List<Doctor> listDoctor = [];
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    //Thông báo lỗi
                  }

                  if (snapshot.hasData) {
                    listDoctor = snapshot.data as List<Doctor>;
                  }
                  return ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                            height: 15,
                          ),
                      itemCount: listDoctor.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var modelDoctor = listDoctor[index];

                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // Điều chỉnh vị trí đổ bóng
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      modelDoctor.image == null
                                          ? AnhMacDinh()
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              child: Image.network(
                                                modelDoctor.image!,
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit.cover,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  return AnhMacDinh();
                                                },
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
                                            modelDoctor.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19),
                                          ),
                                          Text(
                                            modelDoctor.typeDoctor.name,
                                            style: TextStyle(
                                                color: colorTextSubtitle,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            modelDoctor.address,
                                            style: TextStyle(
                                                color: colorTextSubtitle,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
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
                                          modelDoctor.rating == null
                                              ? "5.0"
                                              : modelDoctor!.rating.toString(),
                                          style: TextStyle(color: colorPrimary),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        modelDoctor.gender ? "Male" : "Female",
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
                                              context, BookingPage.routeName,
                                              arguments: modelDoctor);
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: colorPrimary,
                                                  width: 1)),
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
                        );
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Container AnhMacDinh() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("./assets/images/doctor/default.jpg"),
        ),
      ),
    );
  }
}
