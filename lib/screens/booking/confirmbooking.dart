import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:intl/intl.dart';
import 'package:project_hk4_mobile/providers/DoctorProvider.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';

class ConfirmBooking extends StatefulWidget {
  static const routeName = "/BookingPage";
  const ConfirmBooking({super.key});

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  FocusNode fc_Sympton = FocusNode();
  TextEditingController txt_Sympton = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final idDoctor = ModalRoute.of(context)!.settings.arguments as int;
    DateTime? ngaylamviec =
        Provider.of<DoctorProvider>(context, listen: false).ngaylamviec;
    String? thoigian =
        Provider.of<DoctorProvider>(context, listen: false).thoigian;

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    void aaaa() {
      Provider.of<DoctorProvider>(context, listen: false)
          .PaymentBooking(idDoctor, txt_Sympton.text, context);
    }

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
                    Text(
                      "Time :",
                      style: TextStyle(
                          color: labelInput,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    Divider(
                      height: 1,
                      color: bgColor1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber,
                          ),
                          child: Text(
                            ngaylamviec != null
                                ? DateFormat('dd-MM').format(ngaylamviec)
                                : "...",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                          child: Text(
                            thoigian != null ? thoigian : "...",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      height: 1,
                      color: bgColor1,
                    ),
                    Text(
                      "Sympton :",
                      style: TextStyle(
                          color: labelInput,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextField(
                      controller: txt_Sympton,
                      focusNode: fc_Sympton,
                      maxLines: 4, //or null
                      onSubmitted: (event) {
                        fc_Sympton.unfocus();
                      },
                      onTapOutside: (event) {
                        fc_Sympton.unfocus();
                      },
                      decoration: InputDecoration(
                          labelText: "Enter your sympton",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: colorPrimary)),
                          hintText: "Enter your text here"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 1,
                      color: bgColor1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Fee :",
                          style: TextStyle(
                              color: labelInput,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        Text(
                          "50 \$",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(
                      height: 1,
                      color: bgColor1,
                    ),
                    Text(
                      "Type Payment :",
                      style: TextStyle(
                          color: labelInput,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: 130,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 5)),
                        child:
                            Image.asset("assets/images/logo/paypalimage.jpg")),
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => UsePaypal(
                      sandboxMode: true,
                      clientId:
                          "AV44uI65EejMeiipe4KG9xCTfDYeIxsdG4OLXrguQQf16tWIcKe_jO00FlWA9hrnTWrLs0EDsmmFfIl4",
                      secretKey:
                          "EGKpd9bVcZ46_nMsZCE4bXRIGAbdgkmOXmJYo6aK-xR2XVfbOxIveRdgcETSKdE2YlQkJDwz1vO3hGTH",
                      returnURL: "https://samplesite.com/return",
                      cancelURL: "https://samplesite.com/cancel",
                      transactions: const [
                        {
                          "amount": {
                            "total": '70',
                            "currency": "USD",
                            "details": {
                              "subtotal": '70',
                              "shipping": '0',
                              "shipping_discount": 0
                            }
                          },
                          "description": "The payment transaction description.",
                          "item_list": {
                            "items": [
                              {
                                "name": "Apple",
                                "quantity": 4,
                                "price": '5',
                                "currency": "USD"
                              },
                              {
                                "name": "Pineapple",
                                "quantity": 5,
                                "price": '10',
                                "currency": "USD"
                              }
                            ],
                            // shipping address is Optional
                            "shipping_address": {
                              "recipient_name": "Raman Singh",
                              "line1": "Delhi",
                              "line2": "",
                              "city": "Delhi",
                              "country_code": "IN",
                              "postal_code": "11001",
                              "phone": "+00000000",
                              "state": "Texas"
                            },
                          }
                        }
                      ],
                      note: "PAYMENT_NOTE",
                      onSuccess: (Map params) async {
                        aaaa();
                      },
                      onError: (error) {
                        print("onError: $error");
                        Navigator.pop(context);
                      },
                      onCancel: () {
                        print('cancelled:');
                      },
                    ),
                  ));
                },
                child: Container(
                  width: screenWidth * 0.7,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    "PAYMENT",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
