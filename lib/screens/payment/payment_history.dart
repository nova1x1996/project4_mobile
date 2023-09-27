import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_hk4_mobile/const/const.dart';
import 'package:project_hk4_mobile/model/Appointment.dart';
import 'package:project_hk4_mobile/providers/HistoryAppointment.dart';
import 'package:provider/provider.dart';

class PaymentHistory extends StatefulWidget {
  static const routeName = "/PaymentHistory";

  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text(
          "Payment History",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Container(
        height: double.infinity,
        color: bgColor1,
        width: double.infinity,
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              FutureBuilder(
                future: Provider.of<HistoryAppointment>(context, listen: false)
                    .getListDoctor(),
                builder: (context, snapshot) {
                  List<Appointment> listAppointment = [];
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Failed, Error !.Try Late !"),
                    );
                  }
                  if (snapshot.hasData) {
                    listAppointment = snapshot.data as List<Appointment>;
                  }
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var model = listAppointment[index];
                        return HistoryCard(model);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: listAppointment.length);
                },
              ),
            ],
          ),
        )),
      ),
    );
  }

  Container HistoryCard(Appointment model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Column(
            children: [
              HistoryCardHeader(model.price),
              Divider(
                height: 1,
                color: bgColor1,
              ),
              HistoryCardContent(model.date.add(Duration(days: 1)),
                  model.startTime, model.endTime),
              Divider(
                height: 1,
                color: bgColor1,
              ),
              HistoryCardButton(),
            ],
          )
        ],
      ),
    );
  }

  Padding HistoryCardButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: bgColor1,
              border: Border.all(color: colorPrimary),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            "APPOINTMENT DETAILS",
            style: TextStyle(color: colorPrimary, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Container HistoryCardContent(DateTime date, String start, String end) {
    return Container(
      height: 80,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Date",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              Text(DateFormat('dd-MM-yyyy').format(date).toString(),
                  style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          VerticalDivider(
            width: 1,
            color: bgColor1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Time",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500)),
              Text(
                start + " - " + end,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding HistoryCardHeader(int price) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: bgColor1, borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.credit_card_outlined,
              color: colorPrimary,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("\$ $price",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
              Text(
                "Paypal",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
