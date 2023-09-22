import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_hk4_mobile/const/const.dart';
import 'package:project_hk4_mobile/model/LichLamViec.dart';
import 'package:project_hk4_mobile/providers/DoctorProvider.dart';
import 'package:project_hk4_mobile/screens/booking/confirmbooking.dart';
import 'package:project_hk4_mobile/widget/ShowDiagLog/ExampleSnackbar.dart';
import 'package:project_hk4_mobile/widget/TextTitleMedium.dart';
import 'package:provider/provider.dart';

import '../../model/Doctor.dart';
import '../../widget/ShowDiagLog/log_out.dart';

class BookingPage extends StatefulWidget {
  static const routeName = "/ConfirmBookingPage";
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    final modelDoctor = ModalRoute.of(context)!.settings.arguments as Doctor;
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
      body: Stack(
        children: [
          SingleChildScrollView(
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
                    AvatarDoctor_Booking(modelDoctor),
                    const SizedBox(
                      height: 15,
                    ),
                    TextTitleMedium("Select day"),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                      future:
                          Provider.of<DoctorProvider>(context, listen: false)
                              .getLichFromDoctor(modelDoctor.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("Error"),
                          );
                        }
                        var Listdata = snapshot.data as List<LichLamViec>;
                        if (Listdata.length == 0) {
                          return Center(
                            child: Container(
                              padding: EdgeInsetsDirectional.all(10),
                              color: Colors.amber,
                              child: Text(
                                "This doctor has no available schedule.",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          );
                        }
                        return Container(
                          width: double.infinity,
                          height: 42,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                LichLamViec data = Listdata[index];
                                return Consumer<DoctorProvider>(
                                  builder: (context, value, child) {
                                    return InkWell(
                                      onTap: () {
                                        Provider.of<DoctorProvider>(context,
                                                listen: false)
                                            .checkList(data.id);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: data.click == true
                                              ? colorPrimary
                                              : bgColor1,
                                        ),
                                        child: Text(
                                          DateFormat('dd-MM').format(data.date),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 10,
                                  ),
                              itemCount: Listdata.length),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextTitleMedium("Select time slot"),
                    const SizedBox(
                      height: 10,
                    ),
                    GioLamViecWidget(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
              width: screenWidth,
              height: 70,
              child: InkWell(
                onTap: () {
                  var checkChonNgay =
                      Provider.of<DoctorProvider>(context, listen: false)
                          .listLLV
                          .where((element) => element.click == true);
                  var checkChonGio =
                      Provider.of<DoctorProvider>(context, listen: false)
                          .listGioLamViecREALTIME
                          .where((element) => element.click == true);
                  if (checkChonNgay.length == 0 || checkChonGio.length == 0) {
                    SnackBarShowError(
                        context, "You have not selected a date or time.");
                    return;
                  }
                  Navigator.popAndPushNamed(context, ConfirmBooking.routeName,
                      arguments: modelDoctor.id);
                },
                child: Container(
                  width: screenWidth * 0.7,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "CONTINUE",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.arrow_circle_right_outlined,
                          color: Colors.white, size: 24),
                    ],
                  )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Center AvatarDoctor_Booking(Doctor doctor) {
    return Center(
        child: Column(
      children: [
        doctor.image == null
            ? Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("./assets/images/doctor/default.jpg"),
                  ),
                ),
              )
            : Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(doctor.image!),
                  ),
                ),
              ),
        SizedBox(
          height: 10,
        ),
        Text(
          doctor.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          doctor.typeDoctor.name,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: colorTextSubtitle),
        ),
        Text(
          doctor.email,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Container(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                doctor.rating != null ? doctor.rating.toString() : "5.0",
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
                itemCount:
                    doctor.rating != null ? (doctor!.rating!.toInt()) : 5,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

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
                TextField(),
                TextField(
                  maxLines: 4, //or null

                  decoration: InputDecoration.collapsed(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: colorPrimary)),
                      hintText: "Enter your text here"),
                ),
                SizedBox(height: 20),
                HeaderImageConfirmLogout(),
                const SizedBox(height: 20),
                const Text(
                  "Log out",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Text("Are you sure you want to log-out?"),
                const Spacer(),
                ButtonLogout(context),
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

class SymptonTextField extends StatefulWidget {
  const SymptonTextField({
    super.key,
  });

  @override
  State<SymptonTextField> createState() => _SymptonTextFieldState();
}

class _SymptonTextFieldState extends State<SymptonTextField> {
  FocusNode fc_Sympton = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: fc_Sympton,
      maxLines: 4, //or null
      onSubmitted: (event) {
        fc_Sympton.unfocus();
      },
      onTapOutside: (event) {
        fc_Sympton.unfocus();
      },
      decoration: InputDecoration.collapsed(
          border:
              OutlineInputBorder(borderSide: BorderSide(color: colorPrimary)),
          hintText: "Enter your text here"),
    );
  }
}

class GioLamViecWidget extends StatelessWidget {
  const GioLamViecWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<DoctorProvider>(
        context,
      ).getGioLamViec(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        var listGLV = snapshot.data;
        if (listGLV == null || listGLV.length == 0) {
          return Container();
        }

        return Consumer<DoctorProvider>(
          builder: (context, value, child) => Container(
            height: 160,
            width: double.infinity,
            child: GridView.builder(
              itemCount: listGLV.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisExtent: 45,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                var GLV = listGLV[index];
                return InkWell(
                  onTap: () {
                    Provider.of<DoctorProvider>(context, listen: false)
                        .checkListGioLamViec(GLV.thoigian);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: GLV.click == true ? colorPrimary : bgColor1,
                    ),
                    child: Center(
                      child: Text(
                        GLV.thoigian.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
