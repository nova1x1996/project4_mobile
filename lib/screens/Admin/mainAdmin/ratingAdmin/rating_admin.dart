import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_hk4_mobile/const/const.dart';
import 'package:project_hk4_mobile/providers/RatingAdminProvider.dart';
import 'package:provider/provider.dart';

import '../../../../model/Rating.dart';

class RatingAdmin extends StatefulWidget {
  static const routeName = "RatingAdmin";
  const RatingAdmin({super.key});

  @override
  State<RatingAdmin> createState() => _RatingAdminState();
}

class _RatingAdminState extends State<RatingAdmin> {
  @override
  Widget build(BuildContext context) {
    var listFilter =
        Provider.of<RatingAdminProvider>(context, listen: true).listDay;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(
            "Manager Rating",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: Container(
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                width: double.infinity,
                height: 40,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    width: 60,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: listFilter.length,
                  itemBuilder: (context, index) {
                    var model = listFilter[index];
                    return InkWell(
                      onTap: () {
                        Provider.of<RatingAdminProvider>(context, listen: false)
                            .checkList(model.id);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            border: Border.all(
                                width: 4,
                                color: model.click == true
                                    ? Colors.orange
                                    : Colors.blueGrey),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            model.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: Provider.of<RatingAdminProvider>(context, listen: false)
                    .getListRating(),
                builder: (context, snapshot) {
                  List<Rating> listRating = [];
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    //Thông báo lỗi
                  }

                  if (snapshot.hasData) {
                    listRating = snapshot.data as List<Rating>;
                  }
                  return ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      var model = listRating[index];
                      return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.5), // Màu của bóng
                                spreadRadius: 5, // Độ lan rộng của bóng
                                blurRadius: 7, // Độ mờ của bóng
                                offset: Offset(-1,
                                    3), // Vị trí độ tách bóng theo chiều ngang và dọc
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.brown, width: 2)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Patient",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Doctor",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  model.patient.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(model.doctor.name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('dd/MM/yyyy').format(
                                      DateTime.parse(model.createAt)
                                          .add(Duration(days: 1))),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      model.rating.toInt().toString(),
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Divider(
                                height: 1,
                              ),
                            ),
                            Text(
                              model.comment,
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: listRating.length,
                  );
                },
              )
            ]),
          )),
        ));
  }
}
